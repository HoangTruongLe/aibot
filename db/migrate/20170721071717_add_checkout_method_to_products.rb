class AddCheckoutMethodToProducts < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :status_deliver_time, :string
    add_column :products, :credit_settlement, :string
    add_column :products, :postpay, :string
    add_column :products, :cod, :string
    add_column :products, :bank_transfer, :string
    add_column :products, :store_transfer, :string
    add_column :products, :delivery_date, :date
  end
end
