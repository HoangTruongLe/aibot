class ChangeMessageForm < ActiveRecord::Migration[5.1]
  def up
    connection.execute 'drop table if exists message_forms'
    create_table :message_forms do |t|
      t.references :site
      t.text :form_name
      t.text :api_url
      t.text :form_body
      t.text :generated_body
      t.boolean :activity, :default => true
      t.boolean :auto_generate, :default => true
      t.integer :created_user_id
      t.integer :updated_user_id
      t.timestamps
    end
  end

  def down
  end

end
