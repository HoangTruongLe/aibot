class AddAverageStayingTimeToStory < ActiveRecord::Migration[5.1]
  def change
    add_column :stories, :average_staying_time, :float, default: 0
  end
end
