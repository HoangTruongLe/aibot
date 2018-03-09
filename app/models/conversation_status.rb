class ConversationStatus < ApplicationRecord
  MESSAGE_STACK_LENGTH = 4
  include ScopingConcern
  
  belongs_to :session_statistic
  has_many :message_statistics

  scope :job_done, -> { where(story_job: true) }
  scope :job_pending, -> { where(story_job: false) }
end
