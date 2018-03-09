class Master::KeywordsController < Master::MasterController
  include ApplicationHelper

  before_action :add_keyword_index_path
  before_action :set_keyword, only: [:update, :edit, :show, :destroy]

  def index
    @keyword = Keyword.new
    @q = Keyword.ransack(params[:q])
    @categories = Category.all
    @keywords = @q.result.includes(:master_category).order(:id).page(params[:page])
    @lasted_keyword = Keyword.all.reorder(updated_at: :desc).first
    @lasted_update_user = @lasted_keyword.try(:updated_user).try(:name)
    @lasted_update_time = @lasted_keyword.try(:updated_at)
  end

  def relative_keywords_search
    @q = Keyword.ransack(params[:q])
    @keywords = @q.result.activity.includes(:master_category).order(:id).page(params[:page])
  end

  def create
    @keyword = Keyword.new(keyword_params)
    @keyword.updated_user = current_user
    respond_to do |format|
      if @keyword.save
        format.js
      else
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @keyword.update_attributes(keyword_params)
        @keyword.updated_user = current_user
        @keyword.save
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @keyword.destroy
        format.js
      else
        format.js
      end
    end
  end

  def import_csv
    @line_number, @errors_import_csv = Keyword.import_csv(params[:csv_file])
    @line_number = @line_number - 1
    respond_to do |format|
      format.js
    end
  end

  def export_csv
    @keywords = Keyword.all
    respond_to do |format|
      format.csv { send_data @keywords.to_csv,
                              filename: "keywords-#{Date.today}.csv",
                              type: 'text/csv; charset=shift_jis' }
    end
  end

  private

  def add_keyword_index_path
    add_breadcrumb t('.keyword_management')
  end

  def set_keyword
    @keyword = Keyword.find_by_id(params[:id])
  end

  def keyword_params
    params.require(:keyword).permit(:id, :name, :activity, :cpc, :master_category_id)
  end

end
