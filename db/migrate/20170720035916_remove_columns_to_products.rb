class RemoveColumnsToProducts < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :clicked_type, :string
    remove_column :products, :clicked_id, :integer
  end
end
