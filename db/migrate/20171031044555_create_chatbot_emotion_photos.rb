class CreateChatbotEmotionPhotos < ActiveRecord::Migration[5.1]
  def change
    create_table :chatbot_emotion_photos do |t|
      t.integer :chatbot_id
      t.integer :chatbot_emotion_id
      t.string :name
      t.attachment :avatar
      t.timestamps
    end
  end
end
