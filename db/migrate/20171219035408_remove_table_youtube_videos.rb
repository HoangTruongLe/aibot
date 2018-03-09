class RemoveTableYoutubeVideos < ActiveRecord::Migration[5.1]
  def change
    connection.execute 'drop table if exists youtube_videos'
  end
end
