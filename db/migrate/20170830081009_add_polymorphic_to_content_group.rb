class AddPolymorphicToContentGroup < ActiveRecord::Migration[5.1]
  def change
    add_reference :content_groups, :content, polymorphic: true, index: true
    add_column :content_groups, :message_id, :integer
  end
end
