class CreateResponses < ActiveRecord::Migration[5.1]
  def change
    create_table :responses do |t|
      t.string :response_url
      t.string :response_key
      t.string :response_type
      t.string :message_type
      t.string :title
      t.string :description
      t.string :text_message
      t.string :image_url
      t.boolean :done
      t.boolean :activity, default: true
      t.belongs_to :form, foreign_key: true

      t.timestamps
    end
  end
end
