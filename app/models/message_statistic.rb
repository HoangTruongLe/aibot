class MessageStatistic < ApplicationRecord
  include ScopingConcern

  belongs_to :message
  belongs_to :conversation_status
  belongs_to :site, optional: true
end
