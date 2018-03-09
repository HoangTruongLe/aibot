if @message
  # json.keyword @message.keyword
  # json.tags @message.tags
  json.id @message.id
  json.message_contents do
    json.array! @message.message_contents.order(:row_order) do |mc|
      # Exceptions
      next if mc.content_type == "PhotoGroup" and mc.content.photos.blank?
      next if mc.content_type == "VideoGroup" and mc.content.videos.blank?

      # Data
      json.id mc.id
      json.row_order mc.row_order
      json.content_type mc.content_type
      json.message_id mc.message_id
      json.content do
        if mc.content_type == "TextMessage"
          json.id mc.content.id
          json.content mc.content.content
          json.chatbot_emotion @message.chatbot.try(:name)
          json.chatbot_emotion_image @message.chatbot.chatbot_emotion_photos.find_by(chatbot_emotion_id: mc.content.chatbot_emotion_id).image_url
          json.chatbot_emotion_image_default @message.chatbot.chatbot_emotion_photos.first.image_url
          json.message_id mc.content.message_id
        end
        if mc.content_type == "Question"
          json.id mc.content.id
          json.content mc.content.content
          json.chatbot_emotion @message.chatbot.try(:name)
          json.chatbot_emotion_image @message.chatbot.chatbot_emotion_photos.find_by(chatbot_emotion_id: mc.content.chatbot_emotion_id).image_url
          json.chatbot_emotion_image_default @message.chatbot.chatbot_emotion_photos.first.image_url
          json.message_id mc.content.message_id
          json.answers do
            json.array! mc.content.answers do |ans|
              json.id ans.id
              json.keyword ans.keyword
              json.message_id ans.message_id
              json.content ans.content
              json.question_id ans.question_id
              json.message_id ans.message_id
            end
          end
        end
        if mc.content_type == "LinkCard"
          json.id mc.content.id
          json.url add_params_to_url(mc.content.url, { aretecoid: @session_statistic.id })
          json.title mc.content.title
          json.description mc.content.description
          json.image_url mc.content.image_url
          json.content_type mc.content.content_type
          json.content_id mc.content.content_id
          json.message_id mc.content.message_id
        end
        if mc.content_type == "ProductMessage"
          json.id mc.content.id
          json.product do
            json.id mc.content.product.id
            json.name mc.content.product.name
            json.category mc.content.product.category.name
            json.product_url add_params_to_url(generate_url_with_option(@session_statistic.id, mc.content.product.id, mc.content.product.product_url), { aretecoid: @session_statistic.id })
            json.slug mc.content.product.slug
            json.catch_copy mc.content.product.catch_copy
            json.price number_to_currency(mc.content.product.price, :unit => "¥")
            json.campaign number_to_currency(mc.content.product.campaign.to_i, :unit => "¥")
            json.image_1_url mc.content.product.image_1_url ? mc.content.product.image_1_url.split(",") : []
            json.image_2_url mc.content.product.image_2_url ? mc.content.product.image_2_url.split(",") : []
            json.image_3_url mc.content.product.image_3_url ? mc.content.product.image_3_url.split(",") : []
            json.image_4_url mc.content.product.image_4_url ? mc.content.product.image_4_url.split(",") : []
            json.image_5_url mc.content.product.image_5_url ? mc.content.product.image_5_url.split(",") : []
            json.tags mc.content.product.tags
            json.description mc.content.product.description
            json.site do
              json.id mc.content.product.site.id
              json.name mc.content.product.site.name
              json.site_url mc.content.product.site.site_url
            end
          end
          json.message_id mc.content.message_id
        end
        if mc.content_type == "PhotoGroup"
          json.id mc.content.id
          json.content_type mc.content.content_type
          json.content_id mc.content.content_id
          json.message_id mc.content.message_id
          json.photos do
            json.array! mc.content.photos do |pt|
              json.id pt.id
              json.message_id pt.message_id
              json.photo_file_name pt.photo_file_name
              json.photo_content_type pt.photo_content_type
              json.photo_file_size pt.photo_file_size
              json.photo_updated_at pt.photo_updated_at
              json.photo_url pt.photo.expiring_url
            end
          end
        end
        if mc.content_type == "VideoGroup"
          json.id mc.content.id
          json.video do
            json.id mc.content.videos.last.id
            json.message_id mc.content.videos.last.message_id
            json.video_meta mc.content.videos.last.video_meta
            json.video_file_name mc.content.videos.last.video_file_name
            json.video_content_type mc.content.videos.last.video_content_type
            json.video_updated_at mc.content.videos.last.video_updated_at
            json.video_file_size mc.content.videos.last.video_file_size
            json.video_type mc.content.videos.last.video_type
            json.youtube_url mc.content.videos.last.youtube_url
            json.video_url mc.content.videos.last.video.expiring_url
          end
          json.content_type mc.content.content_type
          json.content_id mc.content.content_id
          json.message_id mc.content.message_id
        end
        if mc.content_type == "Quote"
          json.id mc.content.id
          json.content mc.content.content
          json.quote_url mc.content.quote_url
          json.quote_source mc.content.quote_source
          json.referral_comment mc.content.referral_comment
          json.message_id mc.content.message_id
        end
        if mc.content_type == "FormMessage"
          json.id mc.content.id
          json.content_type mc.content_type
          json.message_id mc.content.message_id
          json.form do
            json.id mc.content.form.id
            json.api_url mc.content.form.api_url
            json.generated_body mc.content.form.generated_body
            json.form_action mc.content.form.form_action
          end
          json.headers do
            json.array! mc.content.form.form_headers do |header|
              json.id header.id
              json.header_key header.header_key
              json.header_value header.header_value
            end
          end
          json.responses do
            json.success do
              json.array! mc.content.form.responses.where(response_type: 'success').order(:position) do |resp|
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
              json.array! mc.content.form.responses.where(response_type: 'error').order(:position) do |resp|
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
else
  json.content_type "TextMessage"
  json.message_contents do
    json.array! [0] do
      json.content do
        json.content "良い回答が見つかりませんでした。ごめんなさい。"
      end
    end
  end
end
