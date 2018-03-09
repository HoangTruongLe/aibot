class CreateTagMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :tag_messages do |t|
      t.integer :tag_id
      t.integer :message_id
      t.timestamps
    end
  end
end
