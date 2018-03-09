class CreatePhotoGroup < ActiveRecord::Migration[5.1]
  def change
    create_table :photo_groups do |t|
      t.integer :photo_group_id
      t.integer :message_id
      t.references :content, polymorphic: true, index: true
      t.timestamps
    end
  end
end
