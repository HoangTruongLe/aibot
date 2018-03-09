class CreateMessageForm < ActiveRecord::Migration[5.1]
  def change
    create_table :message_forms do |t|
      t.integer :message_id
      t.boolean :street_address
      t.boolean :name
      t.boolean :email
      t.boolean :phone_number
    end
  end
end
