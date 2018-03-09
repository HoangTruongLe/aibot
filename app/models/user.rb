class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable,
         :recoverable, :trackable, :validatable, :async
  has_many :category_logs, :dependent => :restrict_with_error
  has_many :product_logs, :dependent => :restrict_with_error

  has_many :owner_categories, class_name: "Category", foreign_key: "owner_id", :dependent => :restrict_with_error
  has_many :user_categories, class_name: "Category", foreign_key: "user_id", :dependent => :restrict_with_error

  has_many :owner_products, class_name: "Product", foreign_key: "owner_id", :dependent => :restrict_with_error
  has_many :user_products, class_name: "Product", foreign_key: "user_id", :dependent => :restrict_with_error

  has_many :created_messages, class_name: "Message", foreign_key: "created_user_id", :dependent => :restrict_with_error
  has_many :updated_messages, class_name: "Message", foreign_key: "updated_user_id", :dependent => :restrict_with_error

  has_many :updated_tutorials, class_name: "Tutorial", foreign_key: "updated_user_id", :dependent => :restrict_with_error
  has_many :updated_lineMessages, class_name: "LineMessage", foreign_key: "updated_user_id", :dependent => :restrict_with_error

  has_many :created_master_categories, class_name: "MasterCategory", foreign_key: "created_user_id", :dependent => :restrict_with_error
  has_many :updated_master_categories, class_name: "MasterCategory", foreign_key: "updated_user_id", :dependent => :restrict_with_error

  has_many :created_keywords, class_name: "Keyword", foreign_key: "created_user_id", :dependent => :restrict_with_error
  has_many :updated_keywords, class_name: "Keyword", foreign_key: "updated_user_id", :dependent => :restrict_with_error

  has_many :created_tags, class_name: "Tag", foreign_key: "created_user_id", :dependent => :restrict_with_error
  has_many :updated_tags, class_name: "Tag", foreign_key: "updated_user_id", :dependent => :restrict_with_error

  has_many :created_forms, class_name: "Form", foreign_key: "created_user_id", :dependent => :restrict_with_error
  has_many :updated_forms, class_name: "Form", foreign_key: "updated_user_id", :dependent => :restrict_with_error

  has_many :site_users, class_name: "Site", foreign_key: "user_id", :dependent => :restrict_with_error

  has_many :users_sites
  has_many :sites, through: :users_sites, :dependent => :restrict_with_error

  validates :name, presence: true
  validates :name, length: { maximum: 100 }
  validates :email, length: { maximum: 50 }
  validates :email, presence: true
  validates :password, length: { in: 6..128 }, allow_blank: true
  validates :site_ids, presence: true, unless: -> { self.has_cached_role? :admin }

  after_create :assign_default_role

  attr_accessor :skip_password_validation

  def self.current_site_id=(id)
    Thread.current[:current_site_id] = id
  end

  def self.current_site_id
    Thread.current[:current_site_id]
  end

  def admin?
    self.has_cached_role? :admin
  end

  def active_for_authentication?
    super && self.activity? # i.e. super && self.is_active
  end

  def inactive_message
    I18n.t('not_authorized_user')
  end

  def send_devise_notification(notification, *args)
    devise_mailer.send(notification, self, *args).deliver_later
  end

  ransacker :id do
    Arel.sql("to_char(\"#{table_name}\".\"id\", '99999999')")
  end

  ACTIVITY = [[I18n.t('categories.form.activity.active'),true], [I18n.t('categories.form.activity.inactive'),false]]

  private

  def assign_default_role
    add_role(:manager) if self.roles.blank?
  end

  def password_required?
    return false if skip_password_validation
    super
  end
end
