class AddUserTypeToChatbotLog < ActiveRecord::Migration[5.1]
  def change
    add_column :chatbot_logs, :user_type, :string
  end
end
