class ChangeSomeColumnOfChatbotLog < ActiveRecord::Migration[5.1]
  def change
    remove_column :chatbot_logs, :messages
    remove_column :chatbot_logs, :products

    add_column :chatbot_logs, :message_array, :integer, array: true, default: []
    add_column :chatbot_logs, :message_type, :string
  end
end
