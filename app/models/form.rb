class Form < ApplicationRecord
  include MessageContentConcern
  include ScopingConcern

  belongs_to :site
  belongs_to :created_user, class_name: 'User', foreign_key: 'created_user_id', optional: true
  belongs_to :updated_user, class_name: 'User', foreign_key: 'updated_user_id', optional: true
  has_many :responses, :dependent => :destroy
  validates :form_name, presence: true
  validates :api_url, presence: true
  has_many :form_headers
  accepts_nested_attributes_for :form_headers, reject_if: :all_blank, allow_destroy: true

  accepts_nested_attributes_for :responses, reject_if: :all_blank, allow_destroy: true
  # for search by id
  ransacker :id do
    Arel.sql("to_char(\"#{table_name}\".\"id\", '99999999')")
  end

end
