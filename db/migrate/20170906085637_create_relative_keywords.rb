class CreateRelativeKeywords < ActiveRecord::Migration[5.1]
  def change
    create_table :relative_keywords do |t|
      t.integer :keyword_id
      t.integer :message_id
      t.timestamps
    end
  end
end
