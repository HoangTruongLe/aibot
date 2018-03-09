class AddSiteIdToMessageStatistics < ActiveRecord::Migration[5.1]
  def change
    add_column :message_statistics, :site_id, :integer
  end
end
