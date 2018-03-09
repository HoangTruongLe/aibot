class AddReferenceToTextMessage < ActiveRecord::Migration[5.1]
  def change
    add_reference :text_messages, :message, foreign_key: true
  end
end
