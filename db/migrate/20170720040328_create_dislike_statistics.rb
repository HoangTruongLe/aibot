class CreateDislikeStatistics < ActiveRecord::Migration[5.1]
  def change
    create_table :dislike_statistics do |t|
      t.references :dislike, polymorphic: true, index: true
      t.text :dislike_reason

      t.timestamps
    end
  end
end
