class RemoveColumnType < ActiveRecord::Migration[5.1]
  def change
    remove_column :messages, :type
  end
end
