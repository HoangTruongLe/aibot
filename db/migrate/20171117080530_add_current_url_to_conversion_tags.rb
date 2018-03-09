class AddCurrentUrlToConversionTags < ActiveRecord::Migration[5.1]
  def change
    add_column :conversion_tags, :current_url, :text
  end
end
