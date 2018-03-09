class AddAibotAddressToSite < ActiveRecord::Migration[5.1]
  def change
  	add_column :sites, :aibot_address, :string
  end
end
