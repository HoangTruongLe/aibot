class AddTagToCategoryLog < ActiveRecord::Migration[5.1]
  def change
    add_column :category_logs, :tags, :text
  end
end
