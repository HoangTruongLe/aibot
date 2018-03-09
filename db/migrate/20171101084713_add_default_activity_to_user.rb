class AddDefaultActivityToUser < ActiveRecord::Migration[5.1]
  def change
    change_column_default :users, :activity, true
  end
end
