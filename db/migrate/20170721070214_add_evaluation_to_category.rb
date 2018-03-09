class AddEvaluationToCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :eval_A_name, :string
    add_column :categories, :eval_A_type, :string
    add_column :categories, :eval_A_value, :string
    add_column :categories, :eval_B_name, :string
    add_column :categories, :eval_B_type, :string
    add_column :categories, :eval_B_value, :string
    add_column :categories, :eval_C_name, :string
    add_column :categories, :eval_C_type, :string
    add_column :categories, :eval_C_value, :string
    add_column :categories, :eval_D_name, :string
    add_column :categories, :eval_D_type, :string
    add_column :categories, :eval_D_value, :string
    add_column :categories, :eval_E_name, :string
    add_column :categories, :eval_E_type, :string
    add_column :categories, :eval_E_value, :string
  end
end
