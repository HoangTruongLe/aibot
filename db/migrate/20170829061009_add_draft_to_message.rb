class AddDraftToMessage < ActiveRecord::Migration[5.1]
  def change
    remove_column :messages, :keywords_id
    remove_column :messages, :tags_id
    add_column :messages, :keyword_id, :integer
    add_column :messages, :tag_id, :integer
    add_column :messages, :is_draft, :boolean, default: false
  end
end
