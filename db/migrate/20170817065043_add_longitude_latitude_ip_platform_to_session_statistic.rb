class AddLongitudeLatitudeIpPlatformToSessionStatistic < ActiveRecord::Migration[5.1]
  def change
    add_column :session_statistics, :location, :string
    add_column :session_statistics, :ip_address, :string
    add_column :session_statistics, :platform, :string
  end
end
