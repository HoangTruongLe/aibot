class CreateTags < ActiveRecord::Migration[5.1]
  def change
    connection.execute 'drop table if exists tags'
    create_table :tags do |t|
      t.string :name
      t.boolean :activity, default: true
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
