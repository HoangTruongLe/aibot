class QuotesController < ApplicationController
  before_action :set_quote, only: [:update, :destroy]

  def create
    @template_id = params[:quote][:quote_id]
    @quote = Quote.new(quote_params)
    add_updated_user(quote_params[:message_id]) if @quote.save
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    add_updated_user(quote_params[:message_id]) if @quote.update_attributes(quote_params)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    add_updated_user(@quote.message_id) if @quote.destroy
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_quote
    @quote = Quote.find_by_id(params[:id])
  end

  def quote_params
    params.require(:quote).permit(:message_id, :content, :quote_source, :quote_url, :referral_comment)
  end

end
