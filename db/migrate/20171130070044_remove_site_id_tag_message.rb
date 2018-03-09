class RemoveSiteIdTagMessage < ActiveRecord::Migration[5.1]
  def up
    remove_column :tag_messages, :site_id
  end

  def down
    add_column :tag_messages, :site_id, :integer
  end
end
