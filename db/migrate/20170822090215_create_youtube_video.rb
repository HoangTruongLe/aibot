class CreateYoutubeVideo < ActiveRecord::Migration[5.1]
  def change
    create_table :youtube_videos do |t|
      t.integer :message_id
      t.string :youtube_url
      t.timestamps
    end
  end
end
