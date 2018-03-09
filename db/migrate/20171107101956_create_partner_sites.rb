class CreatePartnerSites < ActiveRecord::Migration[5.1]
  def change
    create_table :partner_sites do |t|
      t.string :site_url
      t.integer :display_number, default: 1

      t.timestamps
    end
  end
end
