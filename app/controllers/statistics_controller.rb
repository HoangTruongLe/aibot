class StatisticsController < ApplicationController
  include ApplicationHelper

  def products
    add_breadcrumb t('statistics.products.title')
    @products = Product.select(:id, :name).page(params[:page]).order(:id)
  end

  def index
    add_breadcrumb t('statistics.index.title')
    @sessions = SessionStatistic.all.order(updated_at: :desc).page(params[:page])
    @number_of_opening_chatbot = @sessions.size
    total_time = 0
    @sessions.each do |session|
      minus_time = session[:end_time].nil? ? 0 : (session[:end_time] - session[:start_time])
      total_time += minus_time
    end
    @average_interactive_time = @number_of_opening_chatbot > 0 ? (total_time / (@number_of_opening_chatbot)) : 0
    @user_access_total = UserAccess.count
    @chatbot_access_total = SessionStatistic.count
    @sessions
  end

  def conversations
    @conversations = []
    conversation_status = SessionStatistic.find(params[:id]).conversation_status
    if conversation_status
      conversation_status.chatting.each_with_index do |cs, order|
        m = cs.split('*')
        message = format_conversation(eval(m[1] + ".find_by_id(" + m[0] + ")"))
        cv = {
          order: order + 1,
          message: message,
          datetime: m[2]
        }
        @conversations << cv
      end
    end
  end

  private

  def format_conversation message
    data = ""
    if message.class.name == 'TextMessage'
      data = message.content
    end
    if message.class.name == 'Answer'
      data = "
        <div style='color: #4455bb; text-align: right; font-weight: bold'>#{message.content}</div>
      "
    end
    if message.class.name == 'Quote'
      data = "
        <div class='m_editor-quote-textarea'>
          <div class='m_quote-content-wrapper'>
            <div class='m_quote-content'>
              <div class='m_quote-title'><span>❝</span> <strong>#{message.content}</strong></div>
              <div class='m_quote-reference'>
                <a href='#{message.quote_url}' target='_blank'><small>#{message.quote_source}</small></a>
              </div>
              <div class='m_quote-comment'>
                #{message.referral_comment}
              </div>
            </div>
          </div>
          <div style='clear: both'></div>
        </div>
      "
    end
    if message.class.name == 'LinkCard'
      data = "
        <div class='preview-wrapper-linkcard'>
          <a href='#{message.url}' target='_blank'><img src='#{message.image_url}' style='cursor: default;'></a>
          <div class='preview-content'>
            <div class='preview-title'><a href='#{message.url}' target='_blank'>#{message.title}</a></div>
            <div class='preview-description'>#{message.description}</div>
            <a href='#{message.url}' target='_blank' class='preview-page'>詳細を見る</a>
          </div>
        </div>
      "
    end
    if message.class.name == 'Question'
      answers = ""
      message.answers.each do |ans|
        answers += "
          <div class='c_item'>
            <a class='c_btn c_arrow_right c_btn_scroll_hidden' href='#'>
              <span class='c_text'>
                #{ans.content}
              </span>
            </a>
          </div>
        "
      end
      data = "<div class='conversation-question'>
        <div class='c_item c_chat_talk c_layout_1 c_over_scroll cf'>
          <div class='c_list cf'>
            #{answers}
          </div><!-- /c_list -->
        </div></div>
      "
    end
    if message.class.name == 'ProductMessage'
      price = helper.number_to_currency(message.product.price, :unit => "¥", :precision => 0)
      campaign = helper.number_to_currency(message.product.campaign.to_i, :unit => "¥", :precision => 0)
      images = ""
      (1..1).each do |i|
        image = eval("message.product.image_#{i}_url")
        image = image ? image.split(',')[0] : []
        next if image.blank?
        images += "
          <div class='c_item_slide'>\
            <img src='#{image}' alt=''>\
          </div>
        "
      end
      data = "<div class='conversation-product'>
        <div class='c_item c_chat_talk c_layout_2 cf'>
          <div class='c_layout_block cf'>
            <div class='c_thumb_wrap cf'>
              <div class='c_slide js_slider_1 cf'>
                #{images}
              </div>
              <div class='c_label c_sale'>
              </div>
            </div>
            <div class='c_conts_wrap cf'>
              <div class='c_text_wrap'>
                <div class='c_text_1'>
                  #{message.product.name}
                </div>
                <div class='c_text_2'>
                  ##{message.product.category.name}
                </div>
              </div>
              <div class='c_text_lead'>
                #{message.product.catch_copy}
              </div>
              <div class='c_price'>
                <div class='c_price_text c_before'>#{price}</div>
                <div class='c_price_text c_after'>#{campaign}</div>
              </div>
            </div>
            <div class='c_btn_wrap padding cf' style='padding: 10px;'>
              <div class='c_btn_list cf'>
                <a class='c_btn mt0 c_arrow_right user_click' target='_blank' href='#{message.product.product_url}' data-id='#{message.product.id}'>
                  <span>購入する</span>
                </a>
              </div>
            </div>
          </div>
          <div class='c_layout_block_text cf'>
            <div class='c_text c_type1'>
              <a href='#' class='c_btn user_dislike' data-id='#{message.product.id}'>
                <span>この回答は不満ですか？</span>
              </a>
            </div>
          </div>
        </div></div>
      "
    end
    if message.class.name == 'VideoGroup'
      data = ""
      if message.videos.last.youtube_url
        data = "<div class='c_item c_chat_talk c_movie cf' style='text-align: center'><iframe src='#{message.videos.last.youtube_url}' frameborder='0' width='50%' style='min-height: 270px;' allowfullscreen ></iframe></div>";
      else
        data = `
          <div class="c_item c_chat_talk c_movie cf" style='text-align: center'>
            <video class='center-block' width="50%" style="min-height: 270px" controls>
              <source src="${message.videos.last.video_url}" type="video/mp4">
            </video>
          </div>`;
      end
    end
    if message.class.name == 'PhotoGroup'
      photos = ""
      message.photos.each do |pt|
        photos += "<li><img src='#{pt.photo.expiring_url}'/></li>"
      end
      data = "<ul class='conversation-photos'>#{photos}</ul>"
    end
    data
  end

  def helper
    @helper ||= Class.new do
      include ActionView::Helpers::NumberHelper
    end.new
  end

end
