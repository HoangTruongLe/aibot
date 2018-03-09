require 'nkf'
class ProductReport < ApplicationRecord
  include ApplicationHelper
  extend Enumerize
  enumerize :type_report, in: [:hour, :day, :month]

  belongs_to :site
  belongs_to :product

  scope :day_reports, ->{ where(type_report: type_report.day) }

  def self.make_log_hour
    starting_time = Time.zone.now
    product_statistics = ProductStatistic.joins(:site => :api_key).
                          select("product_statistics.site_id, product_id, display_url, api_keys.access_token AS access_token,
                                  SUM(CASE WHEN statistic_type = #{ProductStatistic.statistic_types[:display]} THEN 1 ELSE 0 END) AS display_number,
                                  SUM(CASE WHEN statistic_type = #{ProductStatistic.statistic_types[:click]} THEN 1 ELSE 0 END) AS click_number").
                          where("product_statistics.created_at <= ? AND product_statistics.created_at >= ?",
                                      starting_time, (starting_time - 1.hours).to_datetime).
                          group("product_statistics.site_id, product_id, display_url, api_keys.access_token")

    product_statistics.each do |ps|
      product_report = ProductReport.new
      product_report.site_id = ps.site_id
      product_report.product_id = ps.product_id
      product_report.display_url = ps.display_url
      product_report.api_key = ps.access_token
      product_report.display_number = ps.display_number
      product_report.click_number = ps.click_number
      product_report.click_rate = ((product_report.click_number.to_f / product_report.display_number) * 100).round(2)
      product_report.type_report = type_report.hour
      product_report.save!
    end
    ProductStatistic.where("product_statistics.created_at <= ? AND product_statistics.created_at >= ?",
      starting_time, (starting_time - 1.hours).to_datetime).destroy_all
  end

  def self.make_log_day
    add_new_report(Time.zone.now.beginning_of_day, Time.zone.now.end_of_day, type_report.hour, type_report.day)
  end

  def self.make_log_month
    add_new_report(Time.zone.now.beginning_of_month, Time.zone.now.end_of_month, type_report.day, type_report.month)
  end

  def self.add_new_report(start_time, end_time, type_for_query ,report_type)
    reports = ProductReport.select("site_id, product_id, sum(display_number) as display_number,
                          sum(click_number) as click_number, display_url, api_key").
                  where("created_at >= ? AND created_at <= ? AND  type_report = ?", start_time, end_time, type_for_query).
                  group(:site_id, :product_id, :display_url, :api_key)

    reports.each do |rp|
      product_report = ProductReport.new
      product_report.site_id = rp.site_id
      product_report.product_id = rp.product_id
      product_report.display_url = rp.display_url
      product_report.api_key = rp.api_key
      product_report.display_number = rp.display_number
      product_report.click_number = rp.click_number
      product_report.click_rate = ((rp.click_number.to_f / rp.display_number) * 100).round(2)
      product_report.type_report = report_type
      product_report.save!
    end
  end

  def self.to_csv
    desired_columns = csv_columns.map { |c| I18n.t c, scope: [:activerecord, :attributes, :product_report] }
    csv_str =
      CSV.generate do |csv|
        csv << desired_columns
        all.each do |product_report|
          csv << csv_columns.map{ |attr| product_report.send(attr) }
        end
      end
    NKF::nkf('--sjis -Lw', csv_str)
  end

  def self.csv_columns
    [:product_id, :product_name, :display_url, :site_name, :sales, :sales_per_display, :sales_per_click,
      :display_number, :click_number, :cv_number, :click_rate, :cv_rate, :create_time]
  end

  def create_time
    format_datetime(self.created_at)
  end

  def site_name
    self.try(:site).try(:name)
  end

  def product_name
    self.try(:product).try(:name)
  end
end
