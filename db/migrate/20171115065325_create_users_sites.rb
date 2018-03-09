class CreateUsersSites < ActiveRecord::Migration[5.1]
  def change
    create_table :users_sites do |t|
      t.column :user_id, :integer
      t.column :site_id, :integer
      t.timestamps
    end
  end
end
