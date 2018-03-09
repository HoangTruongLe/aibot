class AddSiteIdToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :site_id, :integer
  end
end
