class AddMessageRelationToLinkCard < ActiveRecord::Migration[5.1]
  def change
    add_column :link_cards, :message_id, :integer
  end
end
