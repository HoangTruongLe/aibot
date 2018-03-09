class LineMessagesController < ApplicationController
  before_action :set_line_message, only: [:show, :edit, :update, :destroy]

  def show
    add_breadcrumb t('line_messages.management')
    add_breadcrumb @line_message.id
  end

  def new
    @line_message = LineMessage.find_or_create_by(chatbot_id: params[:chatbot_id])
    respond_to do |format|
      if @line_message.save
        format.html { redirect_to edit_line_message_path(@line_message) }
      end
    end
  end

  def edit
    add_breadcrumb t('line_messages.management')
    add_breadcrumb @line_message.id
    add_breadcrumb t('line_messages.edit')
  end

  def update
    respond_to do |format|
      if @line_message.update(line_message_params)
        format.html { redirect_to @line_message, notice: t('.line_message_update_successfully') }
        format.json { render :show, status: :ok, location: @line_message }
      else
        format.html { render :edit }
        format.json { render json: @line_message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @line_message.destroy
        format.html { redirect_to chatbots_path, notice: t('.destroy_line_message_successfully') }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_message
      @line_message = LineMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_message_params
      params.require(:line_message).permit(:image, :content, :button_wording, :language_note, :line_address, :chatbot_id, :activity).merge(updated_user: current_user)
    end
end
