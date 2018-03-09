class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :type
      t.references :keywords
      t.references :tags
      t.boolean :activity
      t.integer :priority

      t.timestamps
    end
  end
end
