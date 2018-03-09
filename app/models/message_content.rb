class MessageContent < ApplicationRecord
  belongs_to :content, polymorphic: true
  belongs_to :message, optional: true

  include RankedModel
  ranks :row_order, :with_same => :message_id

  default_scope { order(:row_order) }
end
