class ChatbotLog < ApplicationRecord
  belongs_to :session_statistic, optional: true
end
