class RemoveSomeModels < ActiveRecord::Migration[5.1]
  def change
    connection.execute 'drop table if exists tags'
    connection.execute 'drop table if exists tag_categories'
    connection.execute 'drop table if exists tag_products'
    connection.execute 'drop table if exists input_statistics'
    connection.execute 'drop table if exists site_products'
  end
end
