class AddColumnsToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :product_url, :string
    add_column :products, :slug, :string
    add_column :products, :catch_copy, :string
    add_column :products, :price_per_time, :float
    add_column :products, :price, :float
    add_column :products, :campaign, :string
    add_column :products, :order_site, :string
    add_column :products, :manufacturer, :string
    add_column :products, :specificity, :string
    add_column :products, :content, :text
    add_column :products, :price_details, :string
    add_column :products, :useful_ingredients, :text
    add_column :products, :components, :text
    add_column :products, :usage_target, :string
    add_column :products, :image_1_url, :text
    add_column :products, :image_2_url, :text
    add_column :products, :image_3_url, :text
    add_column :products, :image_4_url, :text
    add_column :products, :image_5_url, :text
    add_column :products, :evaluation_score_a, :integer
    add_column :products, :evaluation_score_b, :integer
    add_column :products, :evaluation_score_c, :integer
    add_column :products, :evaluation_score_d, :integer
    add_column :products, :evaluation_score_e, :integer
    add_column :products, :evaluation_comment_a, :text
    add_column :products, :evaluation_comment_b, :text
    add_column :products, :evaluation_comment_c, :text
    add_column :products, :evaluation_comment_d, :text
    add_column :products, :evaluation_comment_e, :text
    add_column :products, :evaluation_category_a, :text
    add_column :products, :evaluation_category_b, :text
    add_column :products, :evaluation_category_c, :text
    add_column :products, :evaluation_category_d, :text
    add_column :products, :evaluation_category_e, :text
  end
end
