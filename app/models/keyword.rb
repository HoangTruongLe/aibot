require 'nkf'
class Keyword < ApplicationRecord
  include KeywordCpcConcern
  include ScopingConcern

  belongs_to :master_category, optional: true
  has_many :relative_keywords, :dependent => :restrict_with_error
  has_many :messages_relative, class_name: "Message", through: :relative_keywords, source: :message
  has_many :messages, :dependent => :restrict_with_error

  has_many :story_start_keyword, class_name: "Story", foreign_key: "start_keyword_id"
  has_many :story_end_keyword, class_name: "Story", foreign_key: "end_keyword_id"

  belongs_to :created_user, class_name: 'User', foreign_key: 'created_user_id', optional: true
  belongs_to :updated_user, class_name: 'User', foreign_key: 'updated_user_id', optional: true
  belongs_to :site

  validates :name, presence: true
  validates :site_id, presence: true
  validates :master_category_id, presence: true
  validates_length_of :name, :maximum => 200
  validates :name, uniqueness: { scope: :site_id }

  scope :activity, -> { joins(:master_category).where('master_categories.activity = ? and keywords.activity = ?', true, true)}

  ransacker :id do
    Arel.sql("to_char(\"#{table_name}\".\"id\", '99999999')")
  end

  def update_keyword_weight
    return unless self.saved_change_to_cpc?
    update_msg self.messages unless self.messages.blank?
    update_msg self.messages_relative unless self.messages_relative.blank?
  end

  def reindex_elasticseach
    Keyword.reindex
  end

  def self.import_csv file
    errors = []
    line_number = 1
    if file.content_type == "text/csv"
      transaction do
        CSV.foreach(file.path, headers: true, encoding: "cp932:utf-8") do |row|
          line_number = line_number + 1
          keyword = find_by_id(row["id"]) || find_by_id(row["ID"]) || find_by_id(row["Id"]) || new
          desired_columns = accessible_attributes.map { |c| I18n.t c, scope: [:activerecord, :attributes, :keyword] }
          attributes = row.to_hash.slice(*desired_columns)
          attrs = {}
          attributes.map do |attr, value|
            if keyword_attributes.key(attr) == :master_category_name
              byebug
              master_category = MasterCategory.find_by_name(value)
              if master_category
                attrs[:master_category_id] = master_category.id
              else
                errors << { line: line_number, message: ["キーワード カテゴリーを見つけません。"] }
              end
            elsif keyword_attributes.key(attr) == :activity
              attrs[keyword_attributes.key(attr)] = (value.try(:strip) == "有効" ? true : false)
            else
              attrs[keyword_attributes.key(attr)] = value
            end
          end
          keyword.attributes = attrs
          unless keyword.save
            error = {
              line: line_number,
              message: keyword.errors.full_messages
            }
            errors << error
          end
        end
        raise ActiveRecord::Rollback unless errors.blank?
      end
    else
      errors << { line: 0, message: ["CSV形式のファイルをアップロードしてください。"] }
    end
    return line_number, errors
  end

  def self.to_csv
    desired_columns = csv_columns.map { |c| I18n.t c, scope: [:activerecord, :attributes, :keyword] }
    csv_str =
      CSV.generate do |csv|
        csv << desired_columns
        all.order(:id).each do |keyword|
          csv << csv_columns.map{ |attr| keyword.send(attr) }
        end
      end
    NKF::nkf('--sjis -Lw', csv_str)
  end

  def self.keyword_attributes
    attrs = {}
    accessible_attributes.each do |a|
      attrs[a] = I18n.t("activerecord.attributes.keyword.#{a}")
    end
    attrs
  end

  def self.accessible_attributes
    [:id, :name, :activity, :cpc, :master_category_name]
  end

  def self.csv_columns
    [:sylk_id, :name, :activity_column, :cpc, :master_category_name]
  end

  def sylk_id
    self.id
  end

  def master_category_name
    self.try(:master_category).try(:name)
  end

  def activity_column
    self.activity ?  I18n.t('activerecord.attributes.product.active') : I18n.t('activerecord.attributes.product.inactive')
  end
end
