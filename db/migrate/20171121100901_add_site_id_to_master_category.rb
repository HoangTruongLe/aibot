class AddSiteIdToMasterCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :master_categories, :site_id, :integer
  end
end
