class V1::ClickStatisticController < V1::BaseController
  before_action :session_interaction

  def create
    @click_statistic =
      if click_statistic_params[:type] && click_statistic_params[:type] == 'Product'
        Product.find_by_id(click_statistic_params[:id])
      elsif click_statistic_params[:type] && click_statistic_params[:type] == 'Category'
        Category.find_by_id(click_statistic_params[:id])
      end

    clicked = ClickStatistic.where(clicked_type: click_statistic_params[:type],
                                    clicked_id: click_statistic_params[:id],
                                    session_statistic_id: @session_statistic.try(:id))

    if @session_statistic.conversation_status
      # Conversation Click number
      @session_statistic.conversation_status.increment(:click_closing)
      @session_statistic.conversation_status.save

      # Message Click number
      message_statistic = @session_statistic.conversation_status.
                                            message_statistics.
                                            find_or_create_by(message_id: click_statistic_params[:message_id])
      message_statistic.increment(:click_closing)
      message_statistic.save
    end

    if @click_statistic && clicked.blank?
      @click_statistic.click_statistics.build(session_statistic_id: @session_statistic.try(:id)).save
    end
    respond_to do |format|    
      format.json { head :no_content }
    end
  end

  private

  def click_statistic_params
    params.permit(:type, :id, :message_id)
  end
end
