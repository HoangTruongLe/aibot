class AddSessionKeyToCvTransaction < ActiveRecord::Migration[5.1]
  def change
    add_column :cv_transactions, :session_statistic_id, :integer
  end
end
