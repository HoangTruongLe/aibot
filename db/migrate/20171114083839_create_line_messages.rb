class CreateLineMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :line_messages do |t|
      t.attachment :image
      t.text :content
      t.text :button_wording
      t.text :language_note
      t.integer :site_id
      t.integer :updated_user_id

      t.timestamps
    end
    add_index :line_messages, :site_id, unique: true
  end
end
