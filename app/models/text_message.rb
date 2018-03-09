class TextMessage < ApplicationRecord
  include MessageContentConcern
  belongs_to :chatbot_emotion
  has_one :message_content, as: :content, dependent: :destroy
  belongs_to :message, optional: true

  before_create :create_message_content

  def create_message_content
    row_order_position = get_message_content_row_num(self.message_id)
    self.build_message_content(message_id: self.message_id, row_order_position: row_order_position)
  end

  ransacker :content do
    Arel.sql("strip_tags(\"#{table_name}\".\"content\")")
  end
end
