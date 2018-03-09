class AddSiteIdToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :site_id, :integer
  end
end
