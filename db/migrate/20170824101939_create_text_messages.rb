class CreateTextMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :text_messages do |t|
      t.text :content
      t.references :chatbot_emotions
      t.timestamps
    end
  end
end
