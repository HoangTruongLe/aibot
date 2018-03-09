class CreateProductReports < ActiveRecord::Migration[5.1]
  def change
    create_table :product_reports do |t|
      t.integer :product_id
      t.string :display_url
      t.string :api_key
      t.integer :site_id
      t.integer :sales
      t.integer :sales_per_display
      t.integer :sales_per_click
      t.integer :display_number
      t.integer :click_number
      t.integer :cv_number
      t.integer :click_rate
      t.text :type_report

      t.timestamps
    end
  end
end
