class AddSiteIdToCategoryLog < ActiveRecord::Migration[5.1]
  def change
    add_column :category_logs, :site_id, :integer
  end
end
