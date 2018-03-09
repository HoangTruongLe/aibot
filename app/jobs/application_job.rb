class ApplicationJob < ActiveJob::Base
  def update_order_position(content_id, index)
    msg_cnt =  MessageContent.find_by_content_id(content_id.id)
    msg_cnt.update_attributes(row_order_position: index)
  end
end
