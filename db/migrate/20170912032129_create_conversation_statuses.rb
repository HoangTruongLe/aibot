class CreateConversationStatuses < ActiveRecord::Migration[5.1]
  def change
    create_table :conversation_statuses do |t|
      t.references :session_statistic, foreign_key: true
      t.integer :status, array: true, default: []

      t.timestamps
    end
  end
end
