if @message
  json.existed 'true'
  json.text_message @text_message ? ActionView::Base.full_sanitizer.sanitize(@text_message) : ""
  if @chatbot
    json.chatbot do
      json.id @chatbot.id
      json.name @chatbot.name
      json.profile @chatbot.profile
      json.rarity @chatbot.rarity
      json.tag @chatbot.tag
      json.photos do
        json.array! @chatbot.chatbot_emotion_photos do |cb|
          json.name cb.name
          json.chatbot_id cb.chatbot_id
          json.chatbot_emotion_id cb.chatbot_emotion_id
          json.image_url cb.image_url
        end
      end
      if @chatbot.line_message && @chatbot.line_message.activity
        json.line do
          json.image_url @chatbot&.line_message&.image_url
          json.content @chatbot&.line_message&.content
          json.button_wording @chatbot&.line_message&.button_wording
          json.language_note @chatbot&.line_message&.language_note
          json.line_address @chatbot&.line_message&.line_address
        end
      end
      if @chatbot.tutorial && @chatbot.tutorial.activity && @chatbot.tutorial.tutorial_steps
        json.tutorial do
          json.array! @chatbot.tutorial.tutorial_steps.order(:id) do |tutor|
            json.image_url tutor.image_url
            json.title tutor.title
            json.content tutor.content
            json.button_wording tutor.button_wording
          end
        end
      end
    end
  else
    json.chatbot nil
  end
else
  json.existed 'false'
  json.text_message nil
  json.chatbot nil
end
