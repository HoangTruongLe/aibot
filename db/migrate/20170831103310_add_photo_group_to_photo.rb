class AddPhotoGroupToPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :photo_group_id, :integer
  end
end
