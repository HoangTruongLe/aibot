class RemoveColumnsFromCategories < ActiveRecord::Migration[5.1]
  def change
    remove_column :categories, :clicked_type, :string
    remove_column :categories, :clicked_id, :integer
  end
end
