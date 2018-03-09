class CreateMessageContents < ActiveRecord::Migration[5.1]
  def change
    create_table :message_contents do |t|
      t.references :messages
      t.integer :message_content_id
      t.string :type
      t.integer :row_order, default: 0

      t.timestamps
    end
  end
end
