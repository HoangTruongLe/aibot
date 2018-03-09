class AddSiteIdToDislikeStatistics < ActiveRecord::Migration[5.1]
  def change
  	add_column :dislike_statistics, :site_id, :integer
  end
end
