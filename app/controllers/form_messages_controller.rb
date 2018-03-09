class FormMessagesController < ApplicationController
  before_action :set_form_message, only: [:update, :destroy]
  before_action :set_params

  def create
    @template_id = params[:form_message][:form_message_id]
    @form_message = FormMessage.new(form_message_params)
    add_updated_user(form_message_params[:message_id]) if @form_message.save
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    add_updated_user(form_message_params[:message_id]) if @form_message.update_attributes(form_message_params)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    add_updated_user(@form_message.message_id) if @form_message.destroy
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_params
    @p = Form.ransack(params[:q])
    @forms = @p.result.includes(:category, :site).page(params[:page]).order(:id)
  end

  def set_form_message
    @form_message = FormMessage.find_by_id(params[:id])
  end

  def form_message_params
    params.require(:form_message).permit(:message_id, :form_id)
  end
end
