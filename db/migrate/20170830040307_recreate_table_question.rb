class RecreateTableQuestion < ActiveRecord::Migration[5.1]
  def up
    connection.execute 'drop table if exists questions'
    connection.execute 'drop table if exists question_descriptions'
    create_table :questions do |t|
      t.text :content
      t.references :chatbot_emotion
      t.references :message

      t.timestamps
    end
  end
  def down
    drop_table :questions
  end
end
