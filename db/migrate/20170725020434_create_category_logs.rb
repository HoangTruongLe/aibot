class CreateCategoryLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :category_logs do |t|
      t.string :name
      t.string :slug
      t.string :eval_A_name
      t.string :eval_A_type
      t.string :eval_A_value
      t.string :eval_B_name
      t.string :eval_B_type
      t.string :eval_B_value
      t.string :eval_C_name
      t.string :eval_C_type
      t.string :eval_C_value
      t.string :eval_D_name
      t.string :eval_D_type
      t.string :eval_D_value
      t.string :eval_E_name
      t.string :eval_E_type
      t.string :eval_E_value
      t.datetime :deleted_at
      t.references :user
      t.boolean :activity
      t.references :category

      t.timestamps
    end
  end
end
