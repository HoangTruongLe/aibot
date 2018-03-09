class CreateSessionStatistics < ActiveRecord::Migration[5.1]
  def change
    create_table :session_statistics do |t|
      t.string :session_key
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end
end
