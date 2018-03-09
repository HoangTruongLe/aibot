class AddCreatedUserToCategrory < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :owner_id, :integer
  end
end
