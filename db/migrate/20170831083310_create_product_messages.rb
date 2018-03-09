class CreateProductMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :product_messages do |t|
      t.references :product, foreign_key: true
      t.references :message, foreign_key: true

      t.timestamps
    end
  end
end
