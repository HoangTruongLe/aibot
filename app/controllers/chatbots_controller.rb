class ChatbotsController < ApplicationController
  before_action :set_chatbot, only: [:show, :edit, :update, :destroy]
  before_action :add_chatbots_index_path

  def index
    @q = Chatbot.ransack(params[:q])
    @chatbots = @q.result.page(params[:page]).order(:id)
  end

  def show
    add_breadcrumb t('chatbots.detail')
    add_breadcrumb "id #{@chatbot.id}"
    @chatbot_emotion_photos = @chatbot.chatbot_emotion_photos
  end

  def new
    add_breadcrumb t('chatbots.new')
    @chatbot = Chatbot.new
    @chatbot_emotion_photos = emotion_photos
  end

  def edit
    add_breadcrumb t('chatbots.edit')
    add_breadcrumb "id #{@chatbot.id}"
    @chatbot_emotion_photos = chatbot_photos
  end

  def create
    add_breadcrumb t('chatbots.new')
    @chatbot = Chatbot.new(chatbot_params)
    @chatbot.created_user = current_user
    respond_to do |format|
      if @chatbot.save
        format.html { redirect_to @chatbot, notice: t('.chatbot_create_successfully') }
        format.json { render :show, status: :created, location: @chatbot }
      else
        @chatbot_emotion_photos = emotion_photos
        format.html { render action: :new }
        format.json { render json: @chatbot.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    add_breadcrumb t('chatbots.edit')
    add_breadcrumb "id #{@chatbot.id}"
    respond_to do |format|
      if @chatbot.update(chatbot_params)
        format.html { redirect_to @chatbot, notice: t('.chatbot_update_successfully') }
        format.json { render :show, status: :ok, location: @chatbot }
      else
        @chatbot_emotion_photos = chatbot_photos
        format.html { render :edit }
        format.json { render json: @chatbot.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @chatbot.destroy
        format.html { redirect_to chatbots_url, notice: t('.chatbot_destroy_successfully') }
      else
        format.html { redirect_to chatbots_url, notice: t('.chatbot_destroy_unsuccessfully') }
      end
    end
  end

  private
    def set_chatbot
      @chatbot = Chatbot.find(params[:id])
    end

    def emotion_photos
      chatbot_emotion_photos = []
      ChatbotEmotion.all.order(:id).each do |ce|
        cep = ChatbotEmotionPhoto.new
        cep.chatbot_emotion_id = ce.id
        cep.name = ce.emotion
        chatbot_emotion_photos << cep
      end
      return chatbot_emotion_photos
    end

    def chatbot_photos
      if @chatbot.chatbot_emotion_photos.count > 0
        cb_photos = @chatbot.chatbot_emotion_photos.order(:chatbot_emotion_id)
      else
        cb_photos = emotion_photos
      end
      return cb_photos
    end

    def chatbot_params
      params.require(:chatbot).permit(:name, :activity, :profile, :rarity, :tag,
        chatbot_emotion_photos_attributes: [:id, :name, :chatbot_id, :chatbot_emotion_id, :avatar])
    end

    def add_chatbots_index_path
      add_breadcrumb t('chatbots.breadcrumb_title'), chatbots_path
    end
end
