class CreateCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :categories do |t|
      t.string :name
      t.references :clicked, polymorphic: true, index: true

      t.timestamps
    end
  end
end
