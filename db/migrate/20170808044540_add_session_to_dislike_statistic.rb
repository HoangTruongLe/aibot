class AddSessionToDislikeStatistic < ActiveRecord::Migration[5.1]
  def change
    add_column :dislike_statistics, :session_key, :string
  end
end
