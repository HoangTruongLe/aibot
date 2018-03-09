class AddPolymophicToLinkCard < ActiveRecord::Migration[5.1]
  def change
    add_reference :link_cards, :content, polymorphic: true, index: true
  end
end
