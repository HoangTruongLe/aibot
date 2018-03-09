class AddVideoGroupToVideo < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :video_group_id, :integer
  end
end
