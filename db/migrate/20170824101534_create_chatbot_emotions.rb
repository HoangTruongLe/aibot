class CreateChatbotEmotions < ActiveRecord::Migration[5.1]
  def change
    create_table :chatbot_emotions do |t|
      t.string :emotion
      t.timestamps
    end
  end
end
