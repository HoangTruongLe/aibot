class Category < ApplicationRecord
  include ScopingConcern

  acts_as_paranoid
  belongs_to :owner, class_name: "User", optional: true, foreign_key: "owner_id"
  belongs_to :user, class_name: "User", optional: true, foreign_key: "user_id"

  has_many :products
  has_many :category_logs, dependent: :destroy
  has_many :click_statistics, as: :clicked
  has_many :dislike_statistics, as: :dislike

  validates :name, presence: true
  validates :slug, presence: true

  ransacker :id do
    Arel.sql("to_char(\"#{table_name}\".\"id\", '99999999')")
  end

  ACTIVITY = [[I18n.t('categories.form.activity.active'),true], [I18n.t('categories.form.activity.inactive'),false]]

  before_save :create_category_logs

  def create_category_logs
    self.category_logs << CategoryLog.build_from_caterogy(self.as_json) if self.changed?
  end

end
