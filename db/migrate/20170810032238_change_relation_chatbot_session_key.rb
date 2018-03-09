class ChangeRelationChatbotSessionKey < ActiveRecord::Migration[5.1]
  def change
    remove_column :dislike_statistics, :session_key
    remove_column :click_statistics, :session_key

    add_column :dislike_statistics, :session_statistic_id, :integer
    add_column :click_statistics, :session_statistic_id, :integer
  end
end
