class V1::CategoriesController < V1::BaseController
  before_action :set_category, only: [:show, :update, :destroy]
  before_action :session_interaction

  def index
    page = params[:page] || 1
    @categories = Category.includes(:user).page(page)
  end

  def show
  end

  def create
    category = Category.new(category_params)
    if category.save
      render json: {status: 'create success'}
    else
      render json: {status: 'create fail'}
    end
  end

  def update
    if @category.update_attributes(category_params)
      render json: {status: 'update success'}
    else
      render json: {status: 'update fail'}
    end
  end

  def destroy
    if @category && @category.destroy
      render json: {status: 'delete success'}
      return
    end
    render json: {status: 'delete fail'}
  end

  private

  def category_params
    json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
    json_params.require(:category).permit(
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

  def set_category
    @category = Category.find_by_id(params[:id])
  end
end
