class AddActivityToLineMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :line_messages, :activity, :boolean, default: true
  end
end
