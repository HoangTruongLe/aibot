class CreateUserAccesses < ActiveRecord::Migration[5.1]
  def change
    create_table :user_accesses do |t|
      t.string :ip_address

      t.timestamps
    end
  end
end
