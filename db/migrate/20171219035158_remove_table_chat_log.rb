class RemoveTableChatLog < ActiveRecord::Migration[5.1]
  def change
    connection.execute 'drop table if exists chat_logs'
  end
end
