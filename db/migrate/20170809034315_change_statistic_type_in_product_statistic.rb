class ChangeStatisticTypeInProductStatistic < ActiveRecord::Migration[5.1]
  def change
    change_column :product_statistics, :statistic_type, "integer USING statistic_type::integer"
  end
end
