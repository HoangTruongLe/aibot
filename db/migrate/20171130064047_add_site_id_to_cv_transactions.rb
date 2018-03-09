class AddSiteIdToCvTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :cv_transactions, :site_id, :integer
  end
end
