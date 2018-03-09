require 'rails_helper'

RSpec.describe ProductReport, type: :model do
  let (:site) { create(:site) }
  let (:product) { create(:product) }
  let (:product_report) { create(:product_report) }
  describe "Associations" do
    it { should belong_to(:site) }
    it { should belong_to(:product) }
  end

  describe "make_log_hour" do
    before do
      create_list(:product_statistic, 20, site_id: site.id, product_id: product.id, statistic_type: ProductStatistic.statistic_types[:click])
      create_list(:product_statistic, 30, site_id: site.id, product_id: product.id, statistic_type: ProductStatistic.statistic_types[:display])
      ProductReport.make_log_hour
    end

    it 'should create a new record of product_report with type_report == hour' do
      expect(ProductReport.count).to eq(1)
      expect(ProductReport.where(site_id: site.id, product_id: product.id).first.type_report).to eq('hour')
    end

    it 'should delete all reported product_statistic' do
      expect(ProductStatistic.count).to eq(0)
    end

    it 'should calculate the click_number equal 20' do
      expect(ProductReport.first.click_number).to eq(20)
    end

    it 'should calculate the display_number equal 30' do
      expect(ProductReport.first.display_number).to eq(30)
    end
  end

  describe "make_log_day" do
    before do
      type_click = ProductStatistic.statistic_types[:click]
      type_display = ProductStatistic.statistic_types[:display]
      3.times do
        create_list(:product_statistic, 20, site_id: site.id, product_id: product.id, statistic_type: type_click)
        create_list(:product_statistic, 30, site_id: site.id, product_id: product.id, statistic_type: type_display)
        ProductReport.make_log_hour
      end
      ProductReport.make_log_day
      @report_day = ProductReport.where(site_id: site.id,
                                   product_id: product.id,
                                   type_report: ProductReport.type_report.day).first

    end

    it 'should create a new record of product_report with type_report == day' do

      expect(ProductReport.count).to eq(4)
      expect(@report_day.type_report).to eq(ProductReport.type_report.day)
    end

    it 'should calculate the click_number equal 60' do
      expect(@report_day.click_number).to eq(20*3)
    end

    it 'should calculate the display_number equal 90' do
      expect(@report_day.display_number).to eq(30*3)
    end
  end

  describe 'make_log_month' do
    before do
      type_click = ProductStatistic.statistic_types[:click]
      type_display = ProductStatistic.statistic_types[:display]
      3.times do
        3.times do
          create_list(:product_statistic, 20, site_id: site.id, product_id: product.id, statistic_type: type_click)
          create_list(:product_statistic, 30, site_id: site.id, product_id: product.id, statistic_type: type_display)
          ProductReport.make_log_hour
        end
        ProductReport.make_log_day
      end
      ProductReport.make_log_month
      @report_month = ProductReport.where(site_id: site.id,
                                   product_id: product.id,
                                   type_report: ProductReport.type_report.month).first

    end

    it 'should create a new record of product_report with type_report == month' do
      expect(ProductReport.count).to eq(13)
      expect(@report_month.type_report).to eq(ProductReport.type_report.month)
    end

    it 'should calculate the click_number equal 360' do
      expect(@report_month.click_number).to eq(360)
    end

    it 'should calculate the display_number equal 540' do
      expect(@report_month.display_number).to eq(540)
    end
  end


  describe '.to_csv' do
    before do
      type_click = ProductStatistic.statistic_types[:click]
      type_display = ProductStatistic.statistic_types[:display]
      3.times do
        3.times do
          create_list(:product_statistic, 20, site_id: site.id, product_id: product.id, statistic_type: type_click)
          create_list(:product_statistic, 30, site_id: site.id, product_id: product.id, statistic_type: type_display)
          ProductReport.make_log_hour
        end
        ProductReport.make_log_day
      end
      ProductReport.make_log_month
      @report_month = ProductReport.where(site_id: site.id,
                                   product_id: product.id,
                                   type_report: ProductReport.type_report.month).first
      @csv_content = ProductReport.to_csv
    end

		it 'desired_columns' do
			ProductReport.csv_columns.map do |field_name|
				expect(@csv_content).to include(I18n.t field_name, scope: [:activerecord, :attributes, :product_report])
			end
		end
  end
end
