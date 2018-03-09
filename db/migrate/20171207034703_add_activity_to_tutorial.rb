class AddActivityToTutorial < ActiveRecord::Migration[5.1]
  def change
    add_column :tutorials, :activity, :boolean, default: true
  end
end
