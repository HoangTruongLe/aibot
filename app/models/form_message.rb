class FormMessage < ApplicationRecord
  include MessageContentConcern

  belongs_to :form, optional: true
  belongs_to :message, optional: true

  has_one :message_content, as: :content, dependent: :destroy

  before_create :create_message_content

  def create_message_content
    row_order_position = get_message_content_row_num(self.message_id)
    self.build_message_content(message_id: self.message_id, row_order_position: row_order_position)
  end
end
