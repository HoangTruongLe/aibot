class CreateProductStatistics < ActiveRecord::Migration[5.1]
  def change
    create_table :product_statistics do |t|
      t.integer :site_id
      t.integer :product_id
      t.string :statistic_type

      t.timestamps
    end
  end
end
