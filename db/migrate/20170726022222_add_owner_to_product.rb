class AddOwnerToProduct < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :owner_id, :integer
    add_column :products, :csv_file_name, :string
  end
end
