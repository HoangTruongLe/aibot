class CreateMasterCategories < ActiveRecord::Migration[5.1]
  def change
    create_table :master_categories do |t|
      t.string :name
      t.boolean :activity, default: true
      t.integer :parent_id

      t.timestamps
    end
  end
end
