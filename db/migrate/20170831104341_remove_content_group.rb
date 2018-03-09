class RemoveContentGroup < ActiveRecord::Migration[5.1]
  def change
    remove_column :photos, :content_group_id
    remove_column :videos, :content_group_id
  end
end
