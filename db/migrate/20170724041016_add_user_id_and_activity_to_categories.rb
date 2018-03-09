class AddUserIdAndActivityToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :user_id, :integer
    add_column :categories, :activity, :boolean, default: true
  end
end
