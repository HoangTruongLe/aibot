class AddFormActionToForm < ActiveRecord::Migration[5.1]
  def change
    add_column :forms, :form_action, :string, default: 'POST'
  end
end
