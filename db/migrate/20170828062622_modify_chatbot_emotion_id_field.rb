class ModifyChatbotEmotionIdField < ActiveRecord::Migration[5.1]
  def change
    remove_column :text_messages, :chatbot_emotions_id
    add_reference :text_messages, :chatbot_emotion, foreign_key: true
  end
end