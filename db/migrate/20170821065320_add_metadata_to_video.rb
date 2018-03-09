class AddMetadataToVideo < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :video_meta, :string
  end
end
