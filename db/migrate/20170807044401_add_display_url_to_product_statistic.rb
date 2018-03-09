class AddDisplayUrlToProductStatistic < ActiveRecord::Migration[5.1]
  def change
    add_column :product_statistics, :display_url, :string
  end
end
