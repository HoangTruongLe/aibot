class AddStoryJobToConversationStatus < ActiveRecord::Migration[5.1]
  def change
    add_column :conversation_statuses, :story_job, :boolean, default: false
  end
end
