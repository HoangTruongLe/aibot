class AddSiteToProductLog < ActiveRecord::Migration[5.1]
  def change
    add_column :product_logs, :site_id, :integer
  end
end
