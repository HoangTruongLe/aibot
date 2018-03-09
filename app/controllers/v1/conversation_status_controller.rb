class V1::ConversationStatusController < V1::BaseController
  before_action :session_interaction

  def update_conversation_status
    message_id = params[:message_id]
    if @session_statistic
      if @session_statistic.conversation_status
        @session_statistic.conversation_status.status << message_id
        @session_statistic.conversation_status.save
      else
        @session_statistic.build_conversation_status(status: [message_id])
        @session_statistic.save
      end
    end
  end

  def render_conversation
    @messages = []
    @datetime = []
    chatting = @session_statistic.conversation_status.chatting
    chatting.each_with_index do |msg, index|
      id = msg.split('*')[0]
      type = msg.split('*')[1]
      @datetime << msg.split('*')[2]
      next if type == 'Question' and index != chatting.size - 1
      @messages << eval(type + ".find_by_id(" + id + ")")
    end
    @messages
  end

  def update_chatting
    id = params[:id] || '0'
    content_type = params[:content_type] || 'User'
    chatting = id + "*" + content_type + "*" + DateTime.current.to_s
    if @session_statistic && @session_statistic.conversation_status
      @session_statistic.conversation_status.chatting << chatting
      @session_statistic.conversation_status.save
    end
  end
end
