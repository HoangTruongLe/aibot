class CreateFormMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :form_messages do |t|
      t.references :form, foreign_key: true, index: true
      t.references :message, foreign_key: true, index: true

      t.timestamps
    end
  end
end
