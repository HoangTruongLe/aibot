class V1::ApiStatisticsController < V1::BaseController

  def display_statistic
    display_statistics_params.each do |product|
      @ps = ProductStatistic.new(statistic_type: ProductStatistic.statistic_types[:display],
                                  product_id: product[:product_id],
                                  site_id: product[:site_id],
                                  display_url: product[:display_url])
      @ps.save
    end
  end

  def click_statistic
    @ps = ProductStatistic.new(statistic_type: ProductStatistic.statistic_types[:click],
                                product_id: click_statistics_params[:product_id],
                                site_id: click_statistics_params[:site_id],
                                display_url: click_statistics_params[:display_url])
    if @ps.save
      @cv_transaction = CvTransaction.new(product_id: @ps.product_id)
      @cv_transaction.save
    end
  end

  private

  def display_statistics_params
    params.require(:statistics).map do |p|
      p.permit(:site_id, :product_id, :display_url)
    end
  end

  def click_statistics_params
    params.permit(:site_id, :product_id, :display_url)
  end

end
