class FormsController < ApplicationController
  before_action :set_form, only: [:edit, :update, :destroy, :show]
  before_action :add_forms_index_path, only: [:edit, :show]
  before_action :get_meta_for_nested_attributes, only: [:create, :update]

  def index
    @q = Form.ransack(params[:q])
    @forms = @q.result.order(:id).page(params[:page])
  end

  def show
    add_breadcrumb t('forms.form_detail')
  end

  def new
    add_breadcrumb t('forms.new')
    @form = Form.new
  end

  def edit
    add_breadcrumb t('forms.edit')
  end

  def create
    @template_id = params[:form][:form_id]
    @form = Form.new
    @form.created_user = current_user
    @form.updated_user = current_user
    respond_to do |format|
      if @form.update_attributes(form_params)
        format.html { redirect_to @form, notice: t('.form_create_successfully') }
      else
        format.html { render :new }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @form.update_attributes(form_params)
        format.html { redirect_to @form, notice: t('.form_update_successfully') }
      else
        format.html { render :new }
        format.json { render json: @form.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @form.destroy
        format.html { redirect_to forms_path, notice: t('.destroy_form_successfully') }
      end
    end
  end

  private

  def add_forms_index_path
    add_breadcrumb t('forms.breadcrumb_title'), forms_path
  end

  def get_meta_for_nested_attributes
    if params[:form][:responses_attributes]
      params[:form][:responses_attributes].each do |index, value|
        get_meta_inspector(index)
      end
    end
  end

  def get_meta_inspector(res_id)
    begin
      page = MetaInspector.new(params[:form][:responses_attributes][res_id][:response_url], :headers => {'User-Agent' => Settings.meta_inspector.user_agent})
      params[:form][:responses_attributes][res_id][:title] = page.title
      params[:form][:responses_attributes][res_id][:description] = page.description
      params[:form][:responses_attributes][res_id][:image_url] = page.images.best
      return true
    rescue => ex
      return false, []
    end
  end

  def set_form
    @form = Form.find_by_id(params[:id])
  end

  def form_params
    params[:form][:generated_body] = params[:form][:generated_body].gsub('authenticity_token_modified', 'authenticity_token')
    params.require(:form).permit(:form_name, :api_url, :form_body, :generated_body, :activity, :auto_generate, :created_user_id, :form_action,
      form_headers_attributes: [:id, :header_key, :header_value, :done, :_destroy],
      responses_attributes: [:id, :position, :message_type, :text_message, :response_type, :response_url,
        :response_key, :done, :title, :description, :image_url, :_destroy])
  end

end
