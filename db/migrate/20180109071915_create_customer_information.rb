class CreateCustomerInformation < ActiveRecord::Migration[5.1]
  def change
    create_table :customer_informations do |t|
      t.integer :session_statistic_id
      t.string :zipcode
      t.string :prefecture
      t.string :municipality
      t.string :street
      t.string :building
      t.string :name
      t.string :email
      t.string :phone
      t.timestamps
    end
  end
end
