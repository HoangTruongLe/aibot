class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.references :category
      t.references :clicked, polymorphic: true, index: true

      t.timestamps
    end
  end
end
