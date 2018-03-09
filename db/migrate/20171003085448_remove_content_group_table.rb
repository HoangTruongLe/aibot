class RemoveContentGroupTable < ActiveRecord::Migration[5.1]
  def change
    connection.execute 'drop table if exists content_groups'
  end
end
