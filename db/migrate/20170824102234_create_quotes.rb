class CreateQuotes < ActiveRecord::Migration[5.1]
  def change
    create_table :quotes do |t|
      t.text :content
      t.string :quote_url
      t.string :quote_source
      t.string :referral_comment

      t.timestamps
    end
  end
end
