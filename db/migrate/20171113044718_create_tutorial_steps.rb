class CreateTutorialSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :tutorial_steps do |t|
      t.string :name
      t.attachment :image
      t.string :title
      t.text :content
      t.string :button_wording
      t.integer :tutorial_id

      t.timestamps
    end
  end
end
