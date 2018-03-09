class AddContentGroupIdToVideo < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :content_group_id, :integer
  end
end
