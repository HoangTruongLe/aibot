class AddSiteIdToStories < ActiveRecord::Migration[5.1]
  def change
    add_column :stories, :site_id, :integer
  end
end
