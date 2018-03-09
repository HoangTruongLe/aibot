class AddColumnApiKeyToConversionTags < ActiveRecord::Migration[5.1]
  def change
    add_column :conversion_tags, :api_key, :string
    change_column :conversion_tags, :referrer, :text
  end
end
