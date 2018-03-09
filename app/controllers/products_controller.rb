class ProductsController < ApplicationController
  include ApplicationHelper

  before_action :set_product, only: [:show, :edit, :update, :destroy, :logs]
  before_action :add_products_index_path
  before_action :set_product_log, only: [:show_log]

  def index
    @q = Product.ransack(params[:q])
    @products = @q.result.includes(:category, :site).page(params[:page]).order(:id)
  end

  def edit
    add_breadcrumb t('products.edit')
  end

  def update
    add_breadcrumb t('products.edit')
    respond_to do |format|
      @product.user = current_user
      if @product.update_attributes(product_params)
        format.html { redirect_to @product, notice: t('.product_update_successfully') }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    breadcumb_name = "id#{@product.id}"
    add_breadcrumb breadcumb_name
  end

  def logs
    add_breadcrumb "#{@product.id}#{t('.logs.log_title')}"
    @product_logs = @product.product_logs.order("created_at DESC").includes(:user).page(params[:page])
  end

  def show_log
    add_breadcrumb t('.logs.log_title'), logs_product_path(@product_log.product)
    breadcumb_name = "#{format_datetime_ymd(@product_log.product.created_at)}id#{@product_log.product.id}"
    add_breadcrumb breadcumb_name
  end

  def import_csv
    @line_number, @errors_import_csv = Product.import_csv(params[:csv_file], current_user)
    @line_number = @line_number - 1
    respond_to do |format|
      format.js
    end
  end

  def destroy
    respond_to do |format|
      if @product.destroy
        format.html { redirect_to products_path, notice: t('.destroy_product_successfully') }
      end
    end
  end

  def export_csv
    @products = Product.all
    respond_to do |format|
      format.csv { send_data @products.to_csv,
                              filename: "products-#{Date.today}.csv",
                              type: 'text/csv; charset=shift_jis' }
    end
  end

  def export_report
    start_time = DateTime.try(:parse, params[:start_time]).beginning_of_day rescue nil
    end_time = DateTime.try(:parse, params[:end_time]).end_of_day rescue nil
    product_report = ProductReport.day_reports
    product_report = product_report.where("created_at >= ?", start_time) if start_time
    product_report = product_report.where("created_at <= ?", end_time) if end_time
    respond_to do |format|
      format.csv { send_data product_report.to_csv,
                            filename: "product-report-#{Date.today}.csv",
                            type: 'text/csv; charset=shift_jis' }
    end
  end

  private

  def set_product_log
    @product_log = ProductLog.find_by_id(params[:id])
  end

  def add_products_index_path
    add_breadcrumb t('.product_title'), :products_path
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(
      :activity,
      :category_id,
      :site_id,
      :name,
      :slug,
      :product_rul,
      :campaign,
      :order_site,
      :status_deliver_time,
      :credit_settlement,
      :postpay,
      :cod,
      :bank_transfer,
      :store_transfer,
      :delivery_date,
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
      :manufacturer,
      :content,
      :price_details,
      :useful_ingredients,
      :components,
      :usage_target,
      :specificity,
      :evaluation_category_a,
      :evaluation_category_b,
      :evaluation_category_c,
      :evaluation_category_d,
      :evaluation_category_e,
      :image_1_url,
      :image_2_url,
      :image_3_url,
      :image_4_url,
      :image_5_url,
      :product_url,
      :catch_copy,
      :price_per_time,
      :price,
      :money_back,
      :summary,
      :tags,
      :description,
      :owner_id
    )
  end
end
