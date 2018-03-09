class MessageContentsController < ApplicationController
  before_action :set_message_content, only: [:update]
  before_action do
    add_updated_user(@message_content.message_id)
  end

  def update
    respond_to do |format|
      if @message_content.update_attributes(message_content_params)
        format.json { render json: {status: :ok} }
      else
        format.json { render json: @message_content.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_message_content
    @message_content = MessageContent.find_by_id(message_content_params[:id])
  end

  def message_content_params
    params.require(:message_content).permit(:id, :row_order_position)
  end
end
