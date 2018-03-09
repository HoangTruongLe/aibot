class AddUserIdAndActivityToProducts < ActiveRecord::Migration[5.1]
  def change
  	add_column :products, :user_id, :integer
    add_column :products, :activity, :boolean, default: true
  end
end
