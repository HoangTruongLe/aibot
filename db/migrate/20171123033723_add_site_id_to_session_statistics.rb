class AddSiteIdToSessionStatistics < ActiveRecord::Migration[5.1]
  def change
    add_column :session_statistics, :site_id, :integer
  end
end
