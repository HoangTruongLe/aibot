class Master::MasterCategoriesController < Master::MasterController
  include ApplicationHelper

  before_action :add_master_categories_index_path
  before_action :set_master_category, only: [:update, :edit, :show, :destroy]

  def index
    @master_category = MasterCategory.new
    @q = MasterCategory.ransack(params[:q])
    @master_categories = @q.result.order(:id)
    if params[:q].blank? || (params[:q][:name_cont].blank? && params[:q][:activity_eq].blank?)
      @master_categories = @master_categories.where(parent_id: nil)
    end
    @lasted_category = MasterCategory.all.reorder(updated_at: :desc).first
    @lasted_update_user = @lasted_category.try(:updated_user).try(:name)
    @lasted_update_time = @lasted_category.try(:updated_at)
  end

  def create
    @master_category = MasterCategory.new(master_category_params)
    @master_category.updated_user = current_user
    respond_to do |format|
      if @master_category.save
        format.js
      else
        format.js
      end
    end
  end

  def update
    respond_to do |format|
      if @master_category.update_attributes(master_category_params)
        @master_category.updated_user = current_user
        @master_category.save
        format.js
      else
        format.js
      end
    end
  end

  def destroy
    respond_to do |format|
      if @master_category.destroy
        format.js
      else
        format.js
      end
    end
  end

  private

  def add_master_categories_index_path
    add_breadcrumb t('.master_category')
  end

  def set_master_category
    @master_category = MasterCategory.find_by_id(params[:id])
  end

  def master_category_params
    params.require(:master_category).permit(:id, :name, :activity, :parent_id)
  end

end
