class AddChatbotIdToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :chatbot_id, :integer
  end
end
