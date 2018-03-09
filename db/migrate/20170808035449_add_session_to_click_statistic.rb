class AddSessionToClickStatistic < ActiveRecord::Migration[5.1]
  def change
    add_column :click_statistics, :session_key, :string
  end
end
