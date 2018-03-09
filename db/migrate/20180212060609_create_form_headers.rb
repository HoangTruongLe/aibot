class CreateFormHeaders < ActiveRecord::Migration[5.1]
  def change
    create_table :form_headers do |t|
      t.string :header_key
      t.string :header_value
      t.belongs_to :form, foreign_key: true

      t.timestamps
    end
  end
end
