class AddChattingToConversationStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :conversation_statuses, :chatting, :string, array: true, default: []
  end
end
