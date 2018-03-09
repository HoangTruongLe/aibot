class RemoveSiteIdRelativeKeyword < ActiveRecord::Migration[5.1]
  def up
    remove_column :relative_keywords, :site_id
  end

  def down
    add_column :relative_keywords, :site_id, :integer
  end
end
