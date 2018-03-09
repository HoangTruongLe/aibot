class V1::ChatbotLogsController < V1::BaseController
  before_action :session_interaction

  def send_chatbot_log
    if @session_statistic.chatbot_logs.build(user_type: send_chatbot_log_params[:user_type],
                                              message_array: JSON.parse(send_chatbot_log_params[:message_array]),
                                              message_type: send_chatbot_log_params[:message_type]).save
      render json: { status: 'ok' }
    else
      render json: { status: 'fail' }
    end
  end

  private

  def send_chatbot_log_params
    params.permit(:message_array, :message_type, :user_type)
  end
end