class AddSiteIdToTagMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :tag_messages, :site_id, :integer
  end
end
