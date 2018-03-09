class AddTagToProductandCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :tags, :text
    add_column :categories, :tags, :text
  end
end
