class CreateConversionTags < ActiveRecord::Migration[5.1]
  def change
    create_table :conversion_tags do |t|
      t.string :fingerprint
      t.string :referrer
      t.references :session_statistic, foreign_key: true

      t.timestamps
    end
  end
end
