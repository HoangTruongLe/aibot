require 'nkf'
class Message < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  include ModelConcern
  include KeywordCpcConcern
  include MessageStatisticReportConcern
  include ScopingConcern

  acts_as_paranoid

  belongs_to :created_user, class_name: 'User', foreign_key: 'created_user_id', optional: true
  belongs_to :updated_user, class_name: 'User', foreign_key: 'updated_user_id', optional: true
  belongs_to :keyword, optional: true
  belongs_to :answer, optional: true
  belongs_to :site
  belongs_to :chatbot, optional: true

  has_many :photos
  has_many :videos
  has_many :message_contents
  has_many :link_cards
  has_many :photo_groups
  has_many :video_groups
  has_many :questions
  has_many :text_messages
  has_many :quotes
  has_many :product_messages
  has_many :tag_messages
  has_many :tags, through: :tag_messages, dependent: :destroy
  has_many :relative_keywords
  has_many :keywords, through: :relative_keywords, dependent: :destroy
  has_many :message_statistics
  has_many :form_messages

  validates :priority, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :keyword_id, presence: true, :unless => :is_draft
  validates :site_id, presence: true, :unless => :is_draft
  validates :chatbot_id, presence: true, :unless => :is_draft

  before_update :update_message_weight
  before_update :destroy_relative_keywords_and_tags

  after_save do
    AnswerHasNextMessageJob.perform_later if self.keyword_id_changed?
  end

  after_destroy do
    AnswerHasNextMessageJob.perform_later
  end

  enum message_types: { 'オープニングメッセージ': 'open', 'ミドルメッセージ': 'middle', 'クロージングメッセージ': 'close' }
  enum message_exists: { '存在する' => true, '存在しない' => false}

  ransacker :photo_exists do |parent|
    Arel.sql("(select exists (select 1 from photos where messages.id = photos.message_id))")
  end

  ransacker :video_exists do |parent|
    Arel.sql("(select exists (select 1 from videos where messages.id = videos.message_id))")
  end

  ransacker :message_id do
    Arel.sql("to_char(\"#{table_name}\".\"id\", '99999999')")
  end

  scope :published, -> { where(is_draft: false) }
  scope :open, -> { where(message_type: "open") }
  scope :middle, -> { where(message_type: "middle") }
  scope :close, -> { where(message_type: "close") }
  scope :middle_close, -> { where(message_type: ["middle", "close"]) }
  scope :open_middle, -> { where(message_type: ["open", "middle"]) }

  def self.has_next_message(msg_id)
    # return true => don't have next messages and otherwiser
    return !self.joins(:questions => [:answers]).exists?(['messages.id = ? AND answers.has_next_msg = ?', msg_id, false])
  end

  def update_message_weight
    mk_cpc = (self.keyword && self.keyword.cpc) ? self.keyword.cpc : 0
    rk_cpc = []
    self.relative_keywords.each do |rk|
      cpc = (rk.keyword && rk.keyword.cpc) ? rk.keyword.cpc : 0
      rk_cpc << cpc
    end
    weight = calculate_weight(mk_cpc, rk_cpc, self.priority)
    self.weight = weight
  end

  def self.to_csv
    csv_str =
      CSV.generate do |csv|
        csv << message_csv_columns
        self.published.each do |message|
          csv_row = []
          stories, display_number, digestion_number = MessageStatisticReportConcern.msg_statistic(message.id)

          # 'メッセージID'
          csv_row << message.id
          # 'メッセージの種類',
          csv_row << Message.message_types.key(message.message_type)
          # 'メッセージの書き始め？',
          first_msg_content = message.message_contents.where(content_type: 'TextMessage').order(:row_order).try(:first)
          csv_row << ActionView::Base.full_sanitizer.sanitize(ModelConcern.lower_unaccent(first_msg_content.try(:content).try(:content)))
          # 'キーワード',
          csv_row << message.try(:keyword).try(:name)
          # 'CPC',
          msg_cpc = message.try(:keyword).try(:cpc)
          csv_row << msg_cpc
          # '平均 到達CPC（消化したメッセージのCPC)',
          avg_reach_cpc = MessageStatisticReportConcern.average_reach_cpc(stories)
          csv_row << avg_reach_cpc
          # '平均 CPC上昇数',
          csv_row << (avg_reach_cpc - msg_cpc).round(2)
          # '候補数（メッセージの候補に上がった数）',
          csv_row << ""
          # '表示数',
          csv_row << display_number
          # '消化数',
          csv_row << digestion_number
          # 'アンサー数',
          csv_row << digestion_number
          # 'クロージングリンククリック数',
          closing_click = message.try(:message_statistics).try(:last).try(:click_closing) || 0
          csv_row << closing_click
          # 'CV数⑤',
          cv_number = MessageStatisticReportConcern.conversion_tags_number(message.id, ConversationStatus.all)
          csv_row << cv_number
          # '消化率',
          csv_row << helpers.number_to_percentage((display_number == 0) ? 0 : (digestion_number.to_f / display_number.to_f * 100), precision: 2)
          # 'アンサー率',
          csv_row << helpers.number_to_percentage((display_number == 0) ? 0 : (digestion_number.to_f / display_number.to_f * 100), precision: 2)
          # 'クロージングリンククリック率',
          csv_row << helpers.number_to_percentage((display_number == 0) ? 0 : (closing_click.to_f / display_number.to_f * 100), precision: 2)
          # 'CV率',
          # TODO
          csv_row << ""
          # '平均滞在時間メッセージ滞在時間',
          csv_row << helpers.number_with_delimiter(MessageStatisticReportConcern.average_stay_time(message))
          # '平均メッセージ消化数',
          average_number_messages_digest, average_number_messages_digest_before, average_number_messages_digest_after = message ? MessageStatisticReportConcern.average_number_messages_digest(stories, message.id) : [0, 0, 0]
          csv_row << average_number_messages_digest
          # '表示前 平均メッセージ消化数',
          csv_row << average_number_messages_digest_before
          # '消化後 平均メッセージ消化数'
          csv_row << average_number_messages_digest_after

          csv << csv_row
        end
      end
    NKF::nkf('--sjis -Lw', csv_str)
  end

  def message_detail_report
    conversation_statuses = ConversationStatus.all
    csv_str =
      CSV.generate do |csv|
        csv << message_detail_csv_columns
        questions = self.message_contents.where(content_type: 'Question')

        questions.each do |question|
          answers = question.content.answers
          answers.each_with_index do |answer, index|
            csv_row = []

            # 'メッセージID'
            message_id = index == 0 ? self.try(:id) : ""
            csv_row << message_id
            # 'メッセージの書き始め？'
            if index == 0
              first_msg_content = self.message_contents.where(content_type: 'TextMessage').order(:row_order).try(:first)
              csv_row << ActionView::Base.full_sanitizer.sanitize(ModelConcern.lower_unaccent(first_msg_content.try(:content).try(:content)))
            else
              csv_row << ""
            end
            # 'クエスチョンメッセージID'
            csv_row << question.try(:content).try(:id)
            # 'クエスチョンメッセージ'
            csv_row << question.try(:content).try(:content)
            # '表示数'
            display_number = get_question_display_number(conversation_statuses, question)
            csv_row << display_number
            # '離脱率'
            csv_row << ActionController::Base.helpers.number_to_percentage((display_number == 0) ? 0 : ((display_number.to_f - get_answers_click_number(conversation_statuses, answers).to_f) / display_number.to_f * 100), precision: 1)
            # 'アンサー'
            csv_row << answer.try(:content)
            # 'アンサー数'
            get_answer_click_number = get_answer_click_number(conversation_statuses, answer)
            csv_row << get_answer_click_number
            # 'アンサー率'
            csv_row << ActionController::Base.helpers.number_to_percentage((display_number == 0) ? 0 : (get_answer_click_number.to_f / display_number.to_f * 100), precision: 1)
            # '平均到達CPC'
            cpc = self.try(:keyword).try(:cpc) || 0
            stories = Story.where('? = ANY(messages_list)', self.id)
            average_reach_cpc = MessageStatisticReportConcern.average_reach_cpc(stories)
            csv_row << average_reach_cpc
            # '平均 CPC上昇数'
            csv_row << average_reach_cpc - cpc
            # 'クロージングリンククリック率'
            closing_click = self.try(:message_statistics).try(:last).try(:click_closing) || 0
            csv_row << ActionController::Base.helpers.number_to_percentage((display_number == 0) ? 0 : (closing_click.to_f / display_number.to_f * 100), precision: 1)
            # 'CV率'
            csv_row << ""
            # '平均メッセージ消化数'
            average_number_messages_digest, average_number_messages_digest_before, average_number_messages_digest_after = self ? MessageStatisticReportConcern.average_number_messages_digest(stories, self.id) : [0, 0, 0]
            csv_row << average_number_messages_digest
            # '表示前 平均メッセージ消化数'
            csv_row << average_number_messages_digest_before
            # '消化後 平均メッセージ消化数'
            csv_row << average_number_messages_digest_after

            csv << csv_row
          end
        end
      end
    NKF::nkf('--sjis -Lw', csv_str)
  end

  private

  def self.helpers
    ActionController::Base.helpers
  end

  def self.message_csv_columns
    [
      'メッセージID',
      'メッセージの種類',
      'メッセージの書き始め？',
      'キーワード',
      'CPC',
      '平均 到達CPC（消化したメッセージのCPC)',
      '平均 CPC上昇数',
      '候補数（メッセージの候補に上がった数）',
      '表示数',
      '消化数',
      'アンサー数',
      'クロージングリンククリック数',
      'CV数⑤',
      '消化率',
      'アンサー率',
      'クロージングリンククリック率',
      'CV率',
      '平均滞在時間メッセージ滞在時間',
      '平均メッセージ消化数',
      '表示前 平均メッセージ消化数',
      '消化後 平均メッセージ消化数'
    ]
  end

  def message_detail_csv_columns
    [
      'メッセージID',
      'メッセージの書き始め？',
      'クエスチョンメッセージID',
      'クエスチョンメッセージ',
      '表示数',
      '離脱率',
      'アンサー',
      'アンサー数',
      'アンサー率',
      '平均到達CPC',
      '平均 CPC上昇数',
      'クロージングリンククリック率',
      'CV率',
      '平均メッセージ消化数',
      '表示前 平均メッセージ消化数',
      '消化後 平均メッセージ消化数'
    ]
  end

  def get_question_display_number conversation_statuses, question
    count = 0
    c_question = question.content.id.to_s + "*" + "Question"
    conversation_statuses.each do |c|
      question_index = c.chatting.index { |s| s.include?(c_question) } || 0
      count += 1 if question_index != 0
    end
    count
  end

  def get_answer_click_number conversation_statuses, answer
    count = 0
    c_answer = answer.id.to_s + "*" + "Answer"
    conversation_statuses.each do |c|
      answer_index = c.chatting.index { |s| s.include?(c_answer) } || 0
      count += 1 if answer_index != 0
    end
    count
  end

  def get_answers_click_number conversation_statuses, answers
    count = 0
    answers.each do |answer|
      count += get_answer_click_number(conversation_statuses, answer)
    end
    count
  end

  def destroy_relative_keywords_and_tags
    if will_save_change_to_attribute?(:site_id)
      Keyword.unscoped { RelativeKeyword.joins(:keyword).where("keywords.site_id != ? AND message_id = ?", User.current_site_id, self.id).destroy_all }
      Tag.unscoped { TagMessage.joins(:tag).where("tags.site_id != ? AND message_id = ?", User.current_site_id, self.id).destroy_all }
    end
  end
end
