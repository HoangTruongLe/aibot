class AddSiteIdToTag < ActiveRecord::Migration[5.1]
  def change
    add_column :tags, :site_id, :integer
  end
end
