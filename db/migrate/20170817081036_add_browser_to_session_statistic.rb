class AddBrowserToSessionStatistic < ActiveRecord::Migration[5.1]
  def change
    add_column :session_statistics, :browser, :string
  end
end
