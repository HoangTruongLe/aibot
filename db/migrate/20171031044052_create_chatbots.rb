class CreateChatbots < ActiveRecord::Migration[5.1]
  def change
    create_table :chatbots do |t|
      t.string :name
      t.boolean :activity, default: true
      t.text :profile
      t.string :rarity
      t.string :tag
      t.timestamps
    end
    add_column :chatbots, :created_user_id, :integer
  end
end
