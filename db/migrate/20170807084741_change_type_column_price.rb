class ChangeTypeColumnPrice < ActiveRecord::Migration[5.1]
  def change
    change_column :product_reports, :sales, :float
    change_column :product_reports, :sales_per_display, :float
    change_column :product_reports, :sales_per_click, :float
    change_column :product_reports, :display_number, :float
    change_column :product_reports, :click_number, :float
    change_column :product_reports, :cv_number, :float
    change_column :product_reports, :click_rate, :float
    change_column :product_reports, :type_report, :string

    add_column :product_reports, :cv_rate, :float
  end
end
