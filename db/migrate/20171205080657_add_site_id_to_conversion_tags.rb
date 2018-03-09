class AddSiteIdToConversionTags < ActiveRecord::Migration[5.1]
  def change
    add_column :conversion_tags, :site_id, :integer
  end
end
