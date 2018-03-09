class ChangeMessageContentToPolymophic < ActiveRecord::Migration[5.1]
  def change
    remove_column :message_contents, :message_content_id
    remove_column :message_contents, :type
    remove_column :message_contents, :messages_id
    add_column :message_contents, :content_id, :integer
    add_column :message_contents, :content_type, :string
    add_column :message_contents, :message_id, :integer
  end
end
