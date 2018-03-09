class AddYoutubeUrlAndVideoTypeToVideo < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :video_type, :string
    add_column :videos, :youtube_url, :string
  end
end
