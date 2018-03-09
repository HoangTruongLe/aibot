class AddLineAddressToLineMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :line_messages, :line_address, :string
  end
end
