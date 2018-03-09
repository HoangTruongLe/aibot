class CreateClickStatistics < ActiveRecord::Migration[5.1]
  def change
    create_table :click_statistics do |t|
      t.references :clicked, polymorphic: true, index: true
      t.timestamps
    end
  end
end
