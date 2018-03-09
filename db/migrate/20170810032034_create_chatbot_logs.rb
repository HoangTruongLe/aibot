class CreateChatbotLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :chatbot_logs do |t|
      t.text :messages, array: true, default: []
      t.text :products, array: true, default: []
      t.references :session_statistic
      t.timestamps
    end
  end
end
