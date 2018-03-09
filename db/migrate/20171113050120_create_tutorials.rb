class CreateTutorials < ActiveRecord::Migration[5.1]
  def change
    create_table :tutorials do |t|
      t.integer :site_id
      t.integer :updated_user_id
      t.timestamps
    end
  end
end
