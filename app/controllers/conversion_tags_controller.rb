class ConversionTagsController < ApplicationController

  def index
    add_breadcrumb t('.conversion_tag')
    @q = ConversionTag.ransack(params[:q])
    @conversion_tags = @q.result.order(:id).page(params[:page])
  end

  def cv_tags_csv
    start_time = DateTime.try(:parse, params[:start_time]).beginning_of_day rescue nil
    end_time = DateTime.try(:parse, params[:end_time]).end_of_day rescue nil
    conversion_tags = ConversionTag.all
    conversion_tags = conversion_tags.where("created_at >= ?", start_time) if start_time
    conversion_tags = conversion_tags.where("created_at <= ?", end_time) if end_time
    respond_to do |format|
      format.csv { send_data conversion_tags.to_csv,
                              filename: "conversion_tags-statistic-#{Date.today}.csv",
                              type: 'text/csv; charset=shift_jis' }
    end
  end
end
