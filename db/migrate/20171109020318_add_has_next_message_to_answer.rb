class AddHasNextMessageToAnswer < ActiveRecord::Migration[5.1]
  def up
    add_column :answers, :has_next_msg, :boolean, default: false
  end

  def down
    remove_column :answers, :has_next_msg
  end
end
