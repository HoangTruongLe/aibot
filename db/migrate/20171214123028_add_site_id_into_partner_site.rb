class AddSiteIdIntoPartnerSite < ActiveRecord::Migration[5.1]
  def change
    add_column :partner_sites, :site_id, :integer
  end
end
