class AddUniqueToSiteId < ActiveRecord::Migration[5.1]
  def change
    add_index :tutorials, :site_id, unique: true
  end
end
