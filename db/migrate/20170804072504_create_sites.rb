class CreateSites < ActiveRecord::Migration[5.1]
  def change
    create_table :sites do |t|
      t.string :name
      t.string :site_url
      t.references :user

      t.timestamps
    end
  end
end
