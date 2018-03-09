class AddClickClosingToStory < ActiveRecord::Migration[5.1]
  def change
    add_column :stories, :click_closing, :integer, default: 0
  end
end
