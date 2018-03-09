module MessageContentConcern
  def get_message_content_row_num(msg_id)
    MessageContent.where(message_id: msg_id).count
  end
end
