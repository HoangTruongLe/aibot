class RecreateTableAnswer < ActiveRecord::Migration[5.1]
  def up
    connection.execute 'drop table if exists answers'
    create_table :answers do |t|
      t.text :content
      t.references :question
      t.references :message

      t.timestamps
    end
  end

  def down
    connection.execute 'drop table if exists answers'
  end
end
