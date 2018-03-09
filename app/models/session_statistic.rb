class SessionStatistic < ApplicationRecord
  include ScopingConcern
  
  has_many :dislike_statistics
  has_many :click_statistics
  has_many :chatbot_logs
  has_many :cv_transactions
  has_one :conversation_status, :dependent => :destroy
  has_many :conversion_tags
  belongs_to :site, optional: true
  has_one :customer_information

  validates :session_key, presence: true

  before_create :create_start_time
  before_update :update_end_time

  private

  def create_start_time
    self.start_time = Time.zone.now
    self.end_time = Time.zone.now
  end

  def update_end_time
    self.end_time = Time.zone.now
  end

end
