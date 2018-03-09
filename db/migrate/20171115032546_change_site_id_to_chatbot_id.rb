class ChangeSiteIdToChatbotId < ActiveRecord::Migration[5.1]
  def change
    if column_exists? :line_messages, :site_id
      remove_column :line_messages, :site_id, :integer
    end
    unless column_exists? :line_messages, :chatbot_id
      add_column :line_messages, :chatbot_id, :integer
      add_index :line_messages, :chatbot_id, unique: true
    end
  end
end
