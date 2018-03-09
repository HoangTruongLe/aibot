class V1::ProductsController < V1::BaseController
  before_action :set_product, only: [:show, :update, :destroy, :chatbot_show_product]
  before_action :session_interaction

  def chatbot_show_products
    page = params[:page] || 1
    @products = @site.products.includes(:category)
    @products = @products.products_by_category(params[:category]) if params[:category]
    @products = @products.page(page)
    @close_messages = Question.close_messages.where(level: Question.question_levels['list_product'])
    @close_message = @close_messages[rand(@close_messages.size - 1)]
  end

  def chatbot_show_product
    @close_messages = Question.close_messages.where(level: Question.question_levels['product'])
    @close_message = @close_messages[rand(@close_messages.size - 1)]
  end

  def index
    page = params[:page] || 1
    @products = @site.products.includes(:category)
    @products = @products.products_by_category(params[:category]) if params[:category]
    @products = @products.page(page)
  end

  def show
    @categories = []
    Category.all.each do |c|
      category = {
        id: c.id,
        name: c.name
      }
      @categories << category
    end
  end

  def create
    product = Product.new(product_params)
    if product.save
      render json: {status: 'create success'}
    else
      render json: {status: 'create fail'}
    end
  end

  def update
    if @product.update_attributes(product_params)
      render json: {status: 'update success'}
    else
      render json: {status: 'update fail'}
    end
  end

  def destroy
    if @product && @product.destroy
      render json: {status: 'delete success'}
    else
      render json: {status: 'delete fail'}
    end
  end

  private

  def product_params
    json_params = ActionController::Parameters.new(JSON.parse(request.body.read))
    json_params.require(:product).permit(
      :name,
      :activity,
      :category_id,
      :product_url,
      :slug,
      :catch_copy,
      :price_per_time,
      :price,
      :campaign,
      :order_site,
      :manufacturer,
      :specificity,
      :content,
      :price_details,
      :useful_ingredients,
      :components,
      :usage_target,
      :image_1_url,
      :image_2_url,
      :image_3_url,
      :image_4_url,
      :image_5_url,
      :evaluation_score_a,
      :evaluation_score_b,
      :evaluation_score_c,
      :evaluation_score_d,
      :evaluation_score_e,
      :evaluation_comment_a,
      :evaluation_comment_b,
      :evaluation_comment_c,
      :evaluation_comment_d,
      :evaluation_comment_e,
      :evaluation_category_a,
      :evaluation_category_b,
      :evaluation_category_c,
      :evaluation_category_d,
      :evaluation_category_e,
      :status_deliver_time,
      :credit_settlement,
      :postpay,
      :cod,
      :bank_transfer,
      :store_transfer,
      :delivery_date,
      :money_back,
      :summary,
      :description,
      :tags
    ).merge(site_id: @site.id)
  end

  def set_product
    @product = @site.products.find_by_id(params[:id])
  end
end
