class AddSiteIdToClickStatistics < ActiveRecord::Migration[5.1]
  def change
    add_column :click_statistics, :site_id, :integer
  end
end
