class CreateStories < ActiveRecord::Migration[5.1]
  def change
    create_table :stories do |t|
      t.integer :start_keyword_id
      t.integer :end_keyword_id
      t.integer :display_number
      t.integer :messages_list, array: true, default: []

      t.timestamps
    end
  end
end
