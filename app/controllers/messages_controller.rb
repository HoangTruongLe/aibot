class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :destroy, :copy_message, :message_preview]
  before_action :set_upscoped_message, only: [:update, :edit, :message_detail_report, :preview]
  before_action :message_breadcrumb, except: [:edit, :message_preview]
  before_action :keyword, only: [:edit, :index, :update]
  before_action :product, only: [:edit, :update]
  before_action :forms, only: [:edit, :update]
  before_action :message_ranksack, only: [:index, :edit, :update]
  before_action :add_created_user, only: [:create]
  before_action :prevent_xhr_cache, only: [:index]

  def index
  end

  def show
  end

  def new
    add_breadcrumb t('.new_title')
    @message = Message.new(is_draft: true, priority: 50, message_type: 'open', activity: true)

    respond_to do |format|
      @message.created_user = current_user
      if @message.save
        format.html { redirect_to edit_message_path(@message.id) }
      end
    end
  end

  def edit
    if @message.is_draft
      add_breadcrumb t('.new_title')
    else
      add_breadcrumb t('message_title'), messages_path
      add_breadcrumb @message.id
    end
    @chatbot_emotions = ChatbotEmotion.all
    @chatbots = Chatbot.all
    @tags = Tag.activity.all
    @tag_messages = TagMessage.includes(:tag).where(message_id: @message.id)
    @pri_keyword = Keyword.activity.find_by_id(@message.keyword_id)
    @rev_keywords = RelativeKeyword.includes(:keyword).where(message_id: @message.id)
    @message_contents = @message.message_contents.includes(:content).order(:row_order)
  end

  def message_preview
    add_breadcrumb t('message_title'), messages_path
    add_breadcrumb @message.id
    @message_contents = @message.message_contents.includes(:content).order(:row_order) if @message
    respond_to do |format|
      format.html
    end
  end

  def preview
    @message_contents = @message.message_contents.includes(:content).order(:row_order) if @message
    respond_to do |format|
      format.js { render partial: 'messages/message_preview_modal', locals: { message_contents: @message_contents }}
    end

  end

  def copy_message
    new_message = @message.dup
    new_message.id = nil
    copied_message = Message.new(new_message.attributes)
    if copied_message.save
      copied_message.tags = @message.tags
      copied_message.keywords = @message.keywords
      copied_message.save
      MessageJob.perform_later(@message.id, copied_message.id, User.current_site_id)
      redirect_to edit_message_path(copied_message.id)
    end
  end

  def message_detail_report
    respond_to do |format|
      format.csv { send_data @message.message_detail_report.encode(Encoding::SJIS, 'UTF-8', undef: :replace, :invalid => :replace, :replace => ""),
                              filename: "message-detail-report-#{Date.today}.csv",
                              type: 'text/csv; charset=shift_jis' }
    end
  end

  def keyword
    @k = Keyword.activity.ransack(params[:q])
    @keywords = @k.result.includes(:master_category).order(:id).page(params[:page])
  end

  def product
    @p = Product.activity.ransack(params[:q])
    @products = @p.result.includes(:category, :site).order(:id).page(params[:page])
  end

  def forms
    @f = Form.activity.ransack(params[:q])
    @forms = @f.result.order(:id).page(params[:page])
  end

  def create
    add_breadcrumb t('.new_title')
  end

  def update
    respond_to do |format|
      @message.is_draft = false
      if @message.update_attributes(message_params)
        add_updated_user(@message.id)
        format.html { redirect_to message_preview_message_path(@message) }
      else
        flash[:error] = @message.errors.full_messages
        format.html { redirect_to edit_message_path(@message) }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @message.destroy
        format.html { redirect_to messages_path, notice: t('.message_destroy_successfully') }
      end
    end
  end

  def summary_message_report
    respond_to do |format|
      format.csv { send_data Message.to_csv,
                              filename: "summary-message-report-#{Date.today}.csv",
                              type: 'text/csv; charset=shift_jis' }
    end
  end

  private

  def set_upscoped_message
    @message = Message.unscoped.find(params[:id])
  end

  def message_ranksack
    @q = Message.published.ransack(params[:q])
    @messages = @q.result.includes(:keywords, [keyword: :master_category]).order(:id).page(params[:page])
  end

  def set_message
    @message = Message.find(params[:id])
  end

  def message_params
    params[:message][:keyword_ids] = params[:message][:keyword_ids].split(/ /)
    params[:message][:tag_ids] = params[:message][:tag_ids].split(/ /)
    params.require(:message).permit(:id, :priority, :activity, :message_type, :chatbot_id, :keyword_id, :site_id, :keyword_ids => [], :tag_ids => [] )
  end

  def message_breadcrumb
    add_breadcrumb t('message_title'), messages_path
  end
end
