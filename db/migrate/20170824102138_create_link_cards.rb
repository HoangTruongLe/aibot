class CreateLinkCards < ActiveRecord::Migration[5.1]
  def change
    create_table :link_cards do |t|
      t.string :url
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
