class AddClickClosingToConversationStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :conversation_statuses, :click_closing, :integer, default: 0
  end
end
