class ChangeLinkCardColumn < ActiveRecord::Migration[5.1]
  def up
    remove_column :link_cards, :content
    add_column :link_cards, :description, :text
    add_column :link_cards, :image_url, :string
  end

  def down
    remove_column :link_cards, :description
    remove_column :link_cards, :image_url
    add_column :link_cards, :content, :text
  end
end
