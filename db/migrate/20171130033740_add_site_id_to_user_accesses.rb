class AddSiteIdToUserAccesses < ActiveRecord::Migration[5.1]
  def change
    add_column :user_accesses, :site_id, :integer
  end
end
