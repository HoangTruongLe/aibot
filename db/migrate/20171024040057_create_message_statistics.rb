class CreateMessageStatistics < ActiveRecord::Migration[5.1]
  def change
    create_table :message_statistics do |t|
      t.integer :click_closing, default: 0
      t.references :message, foreign_key: true
      t.references :conversation_status, foreign_key: true

      t.timestamps
    end
  end
end
