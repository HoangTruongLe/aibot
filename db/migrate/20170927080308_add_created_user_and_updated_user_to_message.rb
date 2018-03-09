class AddCreatedUserAndUpdatedUserToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :created_user_id, :integer
    add_column :messages, :updated_user_id, :integer
  end
end
