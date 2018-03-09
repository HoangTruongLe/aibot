class AddCreatedAndUpdatedUserToMasterCategory < ActiveRecord::Migration[5.1]
  def change
    add_column :master_categories, :created_user_id, :integer
    add_column :master_categories, :updated_user_id, :integer

    add_column :keywords, :created_user_id, :integer
    add_column :keywords, :updated_user_id, :integer

    add_column :tags, :created_user_id, :integer
    add_column :tags, :updated_user_id, :integer
  end
end
