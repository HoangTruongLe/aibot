class LinkCardsController < ApplicationController
  before_action :set_link_card, only: [:update, :destroy]

  def create
    @template_id = params[:link_card][:link_card_id]
    is_value, link_card = get_meta_inspector()
    if (is_value)
      @link_card = LinkCard.new(link_card)
      is_value = @link_card.save
    end
    add_updated_user(link_card_params[:message_id]) if is_value
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    is_value, link_card = get_meta_inspector()
    is_value = @link_card.update_attributes(link_card) if is_value
    add_updated_user(link_card_params[:message_id]) if is_value
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    add_updated_user(@link_card.message_id) if @link_card.destroy
    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def set_link_card
    @link_card = LinkCard.find_by_id(params[:id])
  end

  def get_meta_inspector
    begin
      page = MetaInspector.new(link_card_params[:url], :headers => {'User-Agent' => Settings.meta_inspector.user_agent})
      new_params = link_card_params.merge!(title: page.title, description: page.description, image_url: page.images.best)
      return true, new_params
    rescue => ex
      return false, []
    end
  end

  def link_card_params
    params.require(:link_card).permit(:message_id, :url, :title, :description, :image_url)
  end
end
