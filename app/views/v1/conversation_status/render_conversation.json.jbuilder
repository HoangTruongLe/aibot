if @messages
  json.messages do
    json.array! @messages.each_with_index.to_a do |(mc, index)|
      json.index index
      if mc.class.name == "TextMessage"
        json.content_type mc.class.name
        json.id mc.id
        json.content do
          json.content mc.content
          json.chatbot_emotion mc.message.chatbot.try(:name)
          json.chatbot_emotion_image mc.message.chatbot.chatbot_emotion_photos.find_by(chatbot_emotion_id: mc.chatbot_emotion_id).image_url
          json.chatbot_emotion_image_default mc.message.chatbot.chatbot_emotion_photos.first.image_url
        end
        json.datetime @datetime[index]
      end
      if mc.class.name == "Answer"
        json.content_type mc.class.name
        json.id mc.id
        json.content do
          json.content mc.content
          json.question_id mc.question_id
          json.message_id mc.message_id
        end
        json.datetime @datetime[index]
      end
      if mc.class.name == "Question"
        json.content_type mc.class.name
        json.id mc.id
        json.content do
          json.content mc.content
          json.chatbot_emotion mc.message.chatbot.try(:name)
          json.chatbot_emotion_image mc.message.chatbot.chatbot_emotion_photos.find_by(chatbot_emotion_id: mc.chatbot_emotion_id).image_url
          json.chatbot_emotion_image_default mc.message.chatbot.chatbot_emotion_photos.first.image_url
          json.answers do
            json.array! mc.answers do |ans|
              json.id ans.id
              json.keyword ans.keyword
              json.content ans.content
              json.question_id ans.question_id
              json.message_id ans.message_id
            end
          end
        end
        json.datetime @datetime[index]
      end
      if mc.class.name == "LinkCard"
        json.content_type mc.class.name
        json.id mc.id
        json.content do
          json.url add_params_to_url(mc.url, { aretecoid: @session_statistic.id })
          json.title mc.title
          json.description mc.description
          json.image_url mc.image_url
        json.message_id mc.message_id
        end
        json.datetime @datetime[index]
      end
      if mc.class.name == "ProductMessage"
        json.content_type mc.class.name
        json.id mc.id
        json.message_id mc.message_id
        json.content do
          json.product do
            json.id mc.product.id
            json.name mc.product.name
            json.category mc.product&.category&.name
            json.product_url add_params_to_url(generate_url_with_option(@session_statistic.id, mc.product.id, mc.product.product_url), { aretecoid: @session_statistic.id })
            json.slug mc.product.slug
            json.catch_copy mc.product.catch_copy
            json.price number_to_currency(mc.product.price, :unit => "¥")
            json.campaign number_to_currency(mc.product.campaign.to_i, :unit => "¥")
            json.image_1_url mc.product.image_1_url ? mc.product.image_1_url.split(",") : []
            json.image_2_url mc.product.image_2_url ? mc.product.image_2_url.split(",") : []
            json.image_3_url mc.product.image_3_url ? mc.product.image_3_url.split(",") : []
            json.image_4_url mc.product.image_4_url ? mc.product.image_4_url.split(",") : []
            json.image_5_url mc.product.image_5_url ? mc.product.image_5_url.split(",") : []
            json.tags mc.product.tags
            json.description mc.product.description
            json.site do
              json.id mc.product.site.id
              json.name mc.product.site.name
              json.site_url mc.product.site.site_url
            end
          end
          json.message_id mc.message_id
        end
        json.datetime @datetime[index]
      end
      if mc.class.name == "PhotoGroup"
        json.content_type mc.class.name
        json.id mc.id
        json.content do
          json.photos do
            json.array! mc.photos do |pt|
              json.id pt.id
              json.photo_file_name pt.photo_file_name
              json.photo_content_type pt.photo_content_type
              json.photo_file_size pt.photo_file_size
              json.photo_updated_at pt.photo_updated_at
              json.photo_url pt.photo.expiring_url
            end
          end
        end
        json.datetime @datetime[index]
      end
      if mc.class.name == "VideoGroup"
        json.content_type mc.class.name
        json.id mc.id
        json.content do
          json.video do
            json.id mc.videos.last.id
            json.video_meta mc.videos.last.video_meta
            json.video_file_name mc.videos.last.video_file_name
            json.video_content_type mc.videos.last.video_content_type
            json.video_updated_at mc.videos.last.video_updated_at
            json.video_file_size mc.videos.last.video_file_size
            json.video_type mc.videos.last.video_type
            json.youtube_url mc.videos.last.youtube_url
            json.video_url mc.videos.last.video.expiring_url
          end
        end
        json.datetime @datetime[index]
      end
      if mc.class.name == "Quote"
        json.content_type mc.class.name
        json.id mc.id
        json.content do
          json.content mc.content
          json.quote_url mc.quote_url
          json.quote_source mc.quote_source
          json.referral_comment mc.referral_comment
        end
        json.datetime @datetime[index]
      end
      if mc.class.name == "FormMessage"
        json.content_type mc.class.name
        json.id mc.id
        json.message_id mc.message_id
        json.content do
          json.form do
            json.id mc.form.id
            json.api_url mc.form.api_url
            json.generated_body mc.form.generated_body
            json.form_action mc.form.form_action
          end
          json.headers do
            json.array! mc.form.form_headers do |header|
              json.id header.id
              json.header_key header.header_key
              json.header_value header.header_value
            end
          end
          json.responses do
            json.success do
              json.array! mc.form.responses.where(response_type: 'success').order(created_at: :desc) do |resp|
                json.message_type resp.message_type
                json.response_url resp.response_url
                json.response_key resp.response_key
                json.response_type resp.response_type
                json.title resp.title
                json.description resp.description
                json.image_url resp.image_url
                json.text_message resp.text_message
              end
            end
            json.error do
              json.array! mc.form.responses.where(response_type: 'error').order(created_at: :desc) do |resp|
                json.message_type resp.message_type
                json.response_url resp.response_url
                json.response_key resp.response_key
                json.response_type resp.response_type
                json.title resp.title
                json.description resp.description
                json.image_url resp.image_url
                json.text_message resp.text_message
              end
            end
          end
        end
      end
    end
  end
end
