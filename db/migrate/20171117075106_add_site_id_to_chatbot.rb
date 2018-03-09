class AddSiteIdToChatbot < ActiveRecord::Migration[5.1]
  def change
    add_column :chatbots, :site_id, :integer
  end
end
