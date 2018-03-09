class ChangeSiteIdToChatbotIdOnTutorial < ActiveRecord::Migration[5.1]
  def change
    if column_exists? :tutorials, :site_id
      remove_column :tutorials, :site_id, :integer
    end
    unless column_exists? :tutorials, :chatbot_id
      add_column :tutorials, :chatbot_id, :integer
      add_index :tutorials, :chatbot_id, unique: true
    end
  end
end
