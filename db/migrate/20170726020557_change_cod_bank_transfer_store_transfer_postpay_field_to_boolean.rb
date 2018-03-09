class ChangeCodBankTransferStoreTransferPostpayFieldToBoolean < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :postpay, 'boolean USING CAST(postpay AS boolean)'
    change_column :products, :cod, 'boolean USING CAST(cod AS boolean)'
    change_column :products, :bank_transfer, 'boolean USING CAST(bank_transfer AS boolean)'
    change_column :products, :store_transfer, 'boolean USING CAST(store_transfer AS boolean)'
  end
end
