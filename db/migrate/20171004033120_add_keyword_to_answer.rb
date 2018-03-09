class AddKeywordToAnswer < ActiveRecord::Migration[5.1]
  def change
    add_column :answers, :keyword, :text, array: true, default: []
  end
end
