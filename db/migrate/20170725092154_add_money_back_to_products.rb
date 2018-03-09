class AddMoneyBackToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :money_back, :string
  end
end
