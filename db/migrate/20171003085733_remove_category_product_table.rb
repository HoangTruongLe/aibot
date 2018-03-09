class RemoveCategoryProductTable < ActiveRecord::Migration[5.1]
  def change
    connection.execute 'drop table if exists category_products'

  end
end
