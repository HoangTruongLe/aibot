class AddActivityToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :activity, :boolean, default: true
  end
end
