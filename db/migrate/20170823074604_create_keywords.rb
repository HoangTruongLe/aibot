class CreateKeywords < ActiveRecord::Migration[5.1]
  def change
    create_table :keywords do |t|
      t.string :name
      t.boolean :activity, default: true
      t.float :cpc
      t.references :master_category

      t.timestamps
    end
  end
end
