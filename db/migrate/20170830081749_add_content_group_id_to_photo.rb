class AddContentGroupIdToPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :content_group_id, :integer
  end
end
