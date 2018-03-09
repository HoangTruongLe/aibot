class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.text :content
      t.integer :type
      t.integer :level
      t.references :answer
      t.timestamps
    end
  end
end
