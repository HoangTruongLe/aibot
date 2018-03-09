class AddSiteIdToApiKeys < ActiveRecord::Migration[5.1]
  def change
    add_column :api_keys, :site_id, :integer
  end
end
