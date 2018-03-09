require 'nkf'
class Product < ApplicationRecord
  include ApplicationHelper
  include ScopingConcern

  acts_as_paranoid
  belongs_to :category, optional: true
  belongs_to :site, optional: true
  belongs_to :owner, class_name: "User", optional: true, foreign_key: "owner_id"
  belongs_to :user, class_name: "User", optional: true, foreign_key: "user_id"

  has_many :click_statistics, as: :clicked
  has_many :dislike_statistics, as: :dislike
  has_many :product_logs
  has_many :product_statistics
  has_many :product_reports
  has_many :cv_transactions

  validates :name, presence: true
  validates :slug, presence: true
  validates :description, presence: true
  validates :site_id, presence: true

  scope :activity, -> { joins(:category).where('categories.activity = ? and products.activity = ?', true, true)}

  before_save :create_product_logs

  ransacker :id do
    Arel.sql("to_char(\"#{table_name}\".\"id\", '99999999')")
  end

  def self.products_by_category(category_name)
    joins(:category).where('categories.name LIKE ?', "%#{category_name}%")
  end

  def create_product_logs
    self.product_logs << ProductLog.build_from_product(self.as_json) if self.changed?
  end

  def self.import_csv file, user
    errors = []
    line_number = 1
    if file.content_type == "text/csv"
      transaction do
        CSV.foreach(file.path, headers: true, encoding: "cp932:utf-8") do |row|
          line_number = line_number + 1
          product = find_by_id(row["id"]) || find_by_id(row["ID"]) || find_by_id(row["Id"]) || new
          desired_columns = accessible_attributes.map { |c| I18n.t c, scope: [:activerecord, :attributes, :product] }
          attributes = row.to_hash.slice(*desired_columns)
          attrs = {}
          product.owner = user if !product
          product.user = user
          attributes.map do |attr, value|
            if product_attributes.key(attr) == :category_name
              category = Category.find_by_name(value)
              if category
                attrs[:category_id] = category.id
              else
                errors << { line: line_number, message: ["カテゴリーを見つけません。"] }
              end
            elsif product_attributes.key(attr) == :site_name
              site_id = Site.find_by_id(User.current_site_id).try(:name) == value ? User.current_site_id : false
              if site_id
                attrs[:site_id] = site_id
              else
                errors << { line: line_number, message: ["サイトーを見つけません。"] }
              end
            elsif csv_boolean_column.include?(product_attributes.key(attr))
              attrs[product_attributes.key(attr)] = (value.try(:strip) == "1" ? true : false)
            elsif product_attributes.key(attr) == :activity
              attrs[product_attributes.key(attr)] = (value.try(:strip) == "有効" ? true : false)
            else
              attrs[product_attributes.key(attr)] = value
            end
          end
          attrs[:csv_file_name] = file.original_filename
          product.attributes = attrs
          unless product.save
            error = {
              line: line_number,
              message: product.errors.full_messages
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

  def self.accessible_attributes
    [:id, :category_name, :name, :site_name, :activity, :product_url, :slug, :description, :catch_copy,
      :price_per_time, :price, :campaign, :order_site, :status_deliver_time, :credit_settlement,
      :postpay, :cod, :store_transfer, :bank_transfer, :delivery_date, :money_back, :tags,
      :evaluation_score_a, :evaluation_score_b, :evaluation_score_c, :evaluation_score_d,
      :evaluation_score_e, :summary, :evaluation_comment_a, :evaluation_comment_b, :evaluation_comment_c,
      :evaluation_comment_d, :evaluation_comment_e, :manufacturer, :content, :price_details,
      :usage_target, :components, :usage_target, :specificity, :evaluation_category_a, :evaluation_category_b,
      :evaluation_category_c, :evaluation_category_d, :evaluation_category_e, :image_1_url,
      :image_2_url, :image_3_url, :image_4_url, :image_5_url]
  end

  def self.product_attributes
    attrs = {}
    accessible_attributes.each do |a|
      attrs[a] = I18n.t("activerecord.attributes.product.#{a}")
    end
    attrs
  end

  def self.to_csv
    desired_columns = csv_columns.map { |c| I18n.t c, scope: [:activerecord, :attributes, :product] }
    csv_str =
      CSV.generate do |csv|
        csv << desired_columns
        all.order(:id).each do |product|
          csv << csv_columns.map{ |attr| product.send(attr) }
        end
      end
    NKF::nkf('--sjis -Lw', csv_str)
  end

  def self.csv_columns
    [:sylk_id, :name, :activity_column, :category_name, :site_name, :product_url, :slug, :catch_copy, :price_per_time,
      :price, :campaign, :order_site, :manufacturer, :specificity, :content, :price_details,
      :useful_ingredients, :components, :usage_target, :image_1_url, :components, :usage_target,
      :image_1_url, :image_2_url, :image_3_url, :image_4_url, :image_5_url, :evaluation_score_a,
      :evaluation_score_b, :evaluation_score_c, :evaluation_score_d, :evaluation_score_e,
      :evaluation_comment_a, :evaluation_comment_b, :evaluation_comment_c, :evaluation_comment_d,
      :evaluation_comment_e, :evaluation_category_a, :evaluation_category_b, :evaluation_category_c,
      :evaluation_category_d, :evaluation_category_e, :status_deliver_time, :credit_settlement,
      :postpay_column, :cod_column, :bank_transfer_column, :store_transfer_column, :delivery_date, :user, :money_back,
      :summary, :tags, :owner, :create_time, :update_time, :description]
  end

  def sylk_id
    self.id
  end

  def activity_column
    self.activity ?  I18n.t('activerecord.attributes.product.active') : I18n.t('activerecord.attributes.product.inactive')
  end

  def category_name
    self.try(:category).try(:name)
  end

  def site_name
    self.try(:site).try(:name)
  end

  def create_time
    format_datetime(self.created_at)
  end

  def update_time
    format_datetime(self.updated_at)
  end

  def user
    User.find_by_id(self.user_id).try(:name)
  end

  def owner
    User.find_by_id(self.owner_id).try(:name)
  end

  def self.csv_boolean_column
    [:postpay, :cod, :bank_transfer, :store_transfer]
  end

  def postpay_column
    csv_format_boolean(self.postpay)
  end

  def cod_column
    csv_format_boolean(self.cod)
  end

  def bank_transfer_column
    csv_format_boolean(self.bank_transfer)
  end

  def store_transfer_column
    csv_format_boolean(self.store_transfer)
  end

  def csv_format_boolean(value)
    value ? 1 : 0
  end
end
