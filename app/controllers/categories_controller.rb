class CategoriesController < ApplicationController
  include ApplicationHelper

  before_action :set_category, only: [:show, :edit, :update, :destroy, :logs]
  before_action :set_category_log, only: [:show_log]
  before_action :add_categories_index_path

  def index
    @q = Category.ransack(params[:q])
    @categories = @q.result.includes(:user).page(params[:page]).order(:id)
  end

  def show
    add_breadcrumb t('.show')
  end

  def new
    add_breadcrumb t('.new')
    @category = Category.new
  end

  def create
    add_breadcrumb t('.new')
    @category = current_user.owner_categories.build(category_params)
    @category.user = current_user
    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: t('.category_create_successfully') }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    add_breadcrumb t('.edit')
  end

  def update
    add_breadcrumb t('.edit')
    respond_to do |format|
      @category.user = current_user
      if @category.update_attributes(category_params)
        format.html { redirect_to @category, notice: t('.category_update_successfully') }
      else
        format.html { render :new }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @category.destroy
        format.html { redirect_to categories_path, notice: t('.destroy_category_successfully') }
      end
    end
  end

  def logs
    add_breadcrumb t('.category_logs')
    page = params[:page] || 1
    @category_logs = @category.category_logs.order("created_at DESC").includes(:user).page(page)
  end

  def show_log
    add_breadcrumb t('.category_logs')
    breadcumb_name = "#{ format_datetime_ymd(@category_log.created_at) } id#{@category_log.category.id}"
    add_breadcrumb breadcumb_name
  end

  private

  def add_categories_index_path
    add_breadcrumb t('.category_title'), :categories_path
  end

  def set_category_log
    @category_log = CategoryLog.find(params[:id])
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def category_params
    params.require(:category).permit(
      :name,
      :slug,
      :activity,
      :eval_A_name,
      :eval_A_type,
      :eval_A_value,
      :eval_B_name,
      :eval_B_type,
      :eval_B_value,
      :eval_C_name,
      :eval_C_type,
      :eval_C_value,
      :eval_D_name,
      :eval_D_type,
      :eval_D_value,
      :eval_E_name,
      :eval_E_type,
      :eval_E_value,
      :tags
    )
  end
end
