set :output, "#{path}/log/cron.log"

every 1.hour do # 1.minute 1.day 1.week 1.month 1.year is also supported
  runner "ProductReport.make_log_hour"
end

every 1.day do # 1.minute 1.day 1.week 1.month 1.year is also supported
  runner "ProductReport.make_log_day"
end

every 1.month do # 1.minute 1.day 1.week 1.month 1.year is also supported
  runner "ProductReport.make_log_month"
end

every 1.day, :at => '0:00' do 
  runner "StoryCreatorJob.perform_later"
end