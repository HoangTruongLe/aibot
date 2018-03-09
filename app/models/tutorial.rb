class Tutorial < ApplicationRecord
  belongs_to :chatbot
  has_many :tutorial_steps, :dependent => :destroy
  accepts_nested_attributes_for :tutorial_steps, allow_destroy: true
  belongs_to :updated_user, class_name: 'User', foreign_key: 'updated_user_id', optional: true
end
