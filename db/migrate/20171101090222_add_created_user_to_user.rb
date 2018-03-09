class AddCreatedUserToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :updated_user_id, :integer
  end
end
