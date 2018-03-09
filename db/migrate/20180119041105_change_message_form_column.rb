class ChangeMessageFormColumn < ActiveRecord::Migration[5.1]
  def change
    add_column :message_forms, :site_id, :integer
    add_column :message_forms, :form_name, :text
    add_column :message_forms, :api_url, :text
    add_column :message_forms, :form_body, :text
    add_column :message_forms, :generated_body, :text
    add_column :message_forms, :activity, :boolean, :default => true
    add_column :message_forms, :auto_generate, :boolean, :default => true
    add_column :message_forms, :created_user_id, :integer
    remove_column :message_forms, :message_id, :integer
    remove_column :message_forms, :street_address, :text
    remove_column :message_forms, :name, :text
    remove_column :message_forms, :phone_number, :text
    remove_column :message_forms, :email, :text
  end
end
