class TextMessagesController < ApplicationController
  before_action :set_text_message, only: [:update, :destroy]

  def create
    @template_id = params[:text_message][:text_message_id]
    @text_message = TextMessage.new(text_message_params)
    add_updated_user(text_message_params[:message_id]) if @text_message.save
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    add_updated_user(text_message_params[:message_id]) if @text_message.update_attributes(text_message_params)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    add_updated_user(@text_message.message_id) if @text_message.destroy
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_text_message
    @text_message = TextMessage.find_by_id(params[:id])
  end

  def text_message_params
    params.require(:text_message).permit(:message_id, :content, :chatbot_emotion_id)
  end
end
