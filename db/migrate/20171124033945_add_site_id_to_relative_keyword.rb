class AddSiteIdToRelativeKeyword < ActiveRecord::Migration[5.1]
  def change
    add_column :relative_keywords, :site_id, :integer
  end
end
