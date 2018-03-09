class AddPositionToResponse < ActiveRecord::Migration[5.1]
  def change
    add_column :responses, :position, :integer
    change_column :responses, :response_type, :string, default: 'success'
  end
end
