class AddSiteIdToConversationStatuses < ActiveRecord::Migration[5.1]
  def change
    add_column :conversation_statuses, :site_id, :integer
  end
end
