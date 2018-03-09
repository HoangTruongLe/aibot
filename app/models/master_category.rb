class MasterCategory < ApplicationRecord
  include SanitizeModelAttributes
  include ScopingConcern
  sanitize_attributes :name

  belongs_to :parent, :class_name => "MasterCategory", :foreign_key => "parent_id", optional: true
  has_many :childs, :class_name => "MasterCategory", :foreign_key => "parent_id", dependent: :restrict_with_error
  has_many :keywords, :dependent => :restrict_with_error
  belongs_to :created_user, class_name: 'User', foreign_key: 'created_user_id', optional: true
  belongs_to :updated_user, class_name: 'User', foreign_key: 'updated_user_id', optional: true
  belongs_to :site

  validates :name, presence: true
  validates :site_id, presence: true
  validates_length_of :name, :maximum => 200
end
