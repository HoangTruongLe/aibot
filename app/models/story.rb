require 'nkf'
class Story < ApplicationRecord
  include ActionView::Helpers::NumberHelper
  include MessageStatisticReportConcern
  include ScopingConcern

  belongs_to :start_keyword, class_name: "Keyword", optional: true, foreign_key: "start_keyword_id"
  belongs_to :end_keyword, class_name: "Keyword", optional: true, foreign_key: "end_keyword_id"

  belongs_to :site, optional: true

  ransacker :id do
    Arel.sql("to_char(\"#{table_name}\".\"id\", '99999999')")
  end

  def self.to_csv
    csv_str =
      CSV.generate do |csv|
        csv << story_csv_columns
        all.order(:id).each do |story|
          conversation_statuses = ConversationStatus.where(status: story.messages_list)
          csv_row = []
          # 'ストーリーID'
          csv_row << story.id
          # 売上
          # TODO
          csv_row << ""
          # 'ストーリー実施数'
          # Column C
          c_data = story.display_number
          csv_row << c_data
          # '開始キーワード'
          csv_row << story.start_keyword.try(:name)
          # '開始CPC'
          csv_row << story.start_keyword.try(:cpc)
          # '最終キーワード'
          csv_row << story.end_keyword.try(:name)
          # '最終CPC'
          csv_row << story.end_keyword.try(:cpc)
          # 'メッセージ構成数'
          csv_row << story.messages_list.size
          # '1ストーリーあたりの売上'
          # TODO
          csv_row << ""
          # 'クロージングメッセージクリック数'
          # Column J
          j_data = story.click_closing
          csv_row << j_data
          # 'CV数'
          # Column K
          k_data = 0
          story.messages_list.each { |msg_id| k_data += MessageStatisticReportConcern.conversion_tags_number(msg_id, conversation_statuses) }
          csv_row << k_data
          # 'クロージングメッセージクリック率'
          csv_row << j_data/c_data
          # 'CV率'
          csv_row << k_data/c_data
          # '平均滞在時間'
          csv_row << story.average_staying_time.round(2)

          csv << csv_row
        end
      end
    NKF::nkf('--sjis -Lw', csv_str)
  end

  def messages_csv_report
    csv_str =
      CSV.generate do |csv|
        csv << messages_story_csv_columns
        conversation_statuses = ConversationStatus.where(status: self.messages_list)
        self.messages_list.each do |msg_id|
          msg = Message.find_by_id(msg_id)
          csv_row = []

          stories, msg_display_number, digestion_number = MessageStatisticReportConcern.msg_statistic(msg_id)
          # メッセージID
          csv_row << msg.try(:id)
          # メッセージの書き始め？
          first_msg_content = msg&.message_contents&.where(content_type: 'TextMessage')&.first
          csv_row << ActionView::Base.full_sanitizer.sanitize(first_msg_content&.content&.content)
          # キーワード
          csv_row << msg.try(:keyword).try(:name)
          # CPC
          cpc = msg.try(:keyword).try(:cpc) || 0
          csv_row << cpc
          # 平均 到達CPC
          average_reach_cpc = MessageStatisticReportConcern.average_reach_cpc(stories)
          csv_row << average_reach_cpc
          # 平均 CPC上昇数
          csv_row << (average_reach_cpc - cpc).round(2)
          # 候補数（メッセージの候補に上がった数）
          csv_row << ""
          # 表示数
          csv_row << msg_display_number
          # 消化数
          csv_row << digestion_number
          # アンサー数
          csv_row << digestion_number
          # クロージングリンククリック数
          click_closing = msg.try(:message_statistics)&.sum(:click_closing)
          csv_row << click_closing
          # CV数
          cv_number = MessageStatisticReportConcern.conversion_tags_number(msg_id, conversation_statuses)
          csv_row << cv_number
          # 消化率
          csv_row << ((msg_display_number == 0) ? 0 : (digestion_number.to_f / msg_display_number.to_f).round(2))
          # アンサー率
          csv_row << ((msg_display_number == 0) ? 0 : (digestion_number.to_f / msg_display_number.to_f).round(2))
          # クロージングリンククリック率
          csv_row << ((msg_display_number == 0) ? 0 : (click_closing.to_f / msg_display_number.to_f).round(2))
          # CV率
          csv_row << ((msg_display_number == 0) ? 0 : (cv_number.to_f / msg_display_number.to_f).round(2))
          # 平均滞在時間
          csv_row << number_with_delimiter(MessageStatisticReportConcern.average_stay_time(msg))
          # 平均メッセージ消化数
          average_number_messages_digest, average_number_messages_digest_before, average_number_messages_digest_after = msg ? MessageStatisticReportConcern.average_number_messages_digest(stories, msg.id) : [0, 0, 0]
          csv_row << average_number_messages_digest
          # 表示前 平均メッセージ消化数
          csv_row << average_number_messages_digest_before
          # 消化後 平均メッセージ消化数
          csv_row << average_number_messages_digest_after

          csv << csv_row
        end
      end
    NKF::nkf('--sjis -Lw', csv_str)
  end

  private

  def self.story_csv_columns
    [
      'ストーリーID',
      '売上',
      'ストーリー実施数',
      '開始キーワード',
      '開始CPC',
      '最終キーワード',
      '最終CPC',
      'メッセージ構成数',
      '1ストーリーあたりの売上',
      'クロージングメッセージクリック数',
      'CV数',
      'クロージングメッセージクリック率',
      'CV率',
      '平均滞在時間'
    ]
  end

  def messages_story_csv_columns
    [
      'メッセージID',
      'メッセージの書き始め？',
      'キーワード',
      'CPC',
      '平均 到達CPC',
      '平均 CPC上昇数',
      '候補数（メッセージの候補に上がった数）',
      '表示数',
      '消化数',
      'アンサー数',
      'クロージングリンククリック数',
      'CV数',
      '消化率',
      'アンサー率',
      'クロージングリンククリック率',
      'CV率',
      '平均滞在時間',
      '平均メッセージ消化数',
      '表示前 平均メッセージ消化数',
      '消化後 平均メッセージ消化数'
    ]
  end

end
