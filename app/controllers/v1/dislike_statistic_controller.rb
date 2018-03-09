class V1::DislikeStatisticController < V1::BaseController
  before_action :session_interaction

  def create
    @dislike_statistic =
      if dislike_statistic_params[:type] && dislike_statistic_params[:type] == 'Product'
        Product.find_by_id(dislike_statistic_params[:id])
      elsif dislike_statistic_params[:type] && dislike_statistic_params[:type] == 'Category'
        Category.find_by_id(dislike_statistic_params[:id])
      end

    dislike = DislikeStatistic.where(dislike_type: dislike_statistic_params[:type],
                                      dislike_id: dislike_statistic_params[:id],
                                      session_statistic_id: @session_statistic.try(:id))
    if @dislike_statistic && dislike.blank?
      if @dislike_statistic.dislike_statistics.build(dislike_reason: dislike_statistic_params[:reason],
                                                      session_statistic_id: @session_statistic.try(:id)).save
        render json: { status: 'ok' }
      else
        render json: { status: 'fail' }
      end
      return
    end
    render json: { status: '' }
  end

  private

  def dislike_statistic_params
    params.permit(:type, :id, :reason)
  end

end
