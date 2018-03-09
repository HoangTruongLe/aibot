class CreateProductLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :product_logs do |t|
      t.string :name
      t.references :category
      t.string :product_url
      t.string :slug
      t.string :catch_copy
      t.float :price_per_time
      t.float :price
      t.string :campaign
      t.string :order_site
      t.string :manufacturer
      t.string :specificity
      t.text :content
      t.string :price_details
      t.text :useful_ingredients
      t.text :components
      t.string :usage_target
      t.text :image_1_url
      t.text :image_2_url
      t.text :image_3_url
      t.text :image_4_url
      t.text :image_5_url
      t.integer :evaluation_score_a
      t.integer :evaluation_score_b
      t.integer :evaluation_score_c
      t.integer :evaluation_score_d
      t.integer :evaluation_score_e
      t.text :evaluation_comment_a
      t.text :evaluation_comment_b
      t.text :evaluation_comment_c
      t.text :evaluation_comment_d
      t.text :evaluation_comment_e
      t.text :evaluation_category_a
      t.text :evaluation_category_b
      t.text :evaluation_category_c
      t.text :evaluation_category_d
      t.text :evaluation_category_e
      t.text :summary
      t.text :money_back
      t.string :status_deliver_time
      t.string :credit_settlement
      t.boolean :postpay
      t.boolean :cod
      t.boolean :bank_transfer
      t.boolean :store_transfer
      t.date :delivery_date
      t.datetime :deleted_at
      t.string :csv_file_name

      t.references :user

      t.references :product

      t.timestamps
    end
  end
end
