class CreateCvTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :cv_transactions do |t|
      t.references :product
      t.string :cv_transaction_key
      t.float :price

      t.timestamps
    end
  end
end
