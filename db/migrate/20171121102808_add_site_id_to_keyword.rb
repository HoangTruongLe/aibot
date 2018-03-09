class AddSiteIdToKeyword < ActiveRecord::Migration[5.1]
  def change
    add_column :keywords, :site_id, :integer
  end
end
