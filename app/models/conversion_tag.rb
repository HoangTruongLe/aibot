require 'nkf'
class ConversionTag < ApplicationRecord
  include ScopingConcern

  belongs_to :session_statistic
  belongs_to :site, optional: true

  def self.to_csv
    csv_str =
      CSV.generate do |csv|
        csv << cv_tags_csv_columns
        all.order(:id).each do |cv|
          csv_row = []
          # '日時'
          csv_row << cv.created_at.try(:strftime, '%Y/%m/%d %H:%M')
          # コンバージョンURL
          csv_row << cv&.current_url
          # 'UserAgent情報'
          csv_row << cv&.session_statistic&.browser
          # 'IPアドレス情報'
          csv_row << cv&.session_statistic&.ip_address

          csv << csv_row
        end
      end
    NKF::nkf('--sjis -Lw', csv_str)
  end

  def self.cv_tags_csv_columns
    [
      '日時',
      'コンバージョンURL',
      'UserAgent情報',
      'IPアドレス情報'
    ]
  end
end
