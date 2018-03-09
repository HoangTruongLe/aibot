class Question < ApplicationRecord
  include MessageContentConcern
  belongs_to :chatbot_emotion
  has_many :answers, :dependent => :destroy
  belongs_to :message, optional: true

  has_one :message_content, as: :content, dependent: :destroy

  accepts_nested_attributes_for :answers, allow_destroy: true
  # validates :content, presence: true

  before_create :create_message_content

  def create_message_content
    row_order_position = get_message_content_row_num(self.message_id)
    self.build_message_content(message_id: self.message_id, row_order_position: row_order_position)
  end

end
