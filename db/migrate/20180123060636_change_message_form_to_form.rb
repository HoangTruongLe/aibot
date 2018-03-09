class ChangeMessageFormToForm < ActiveRecord::Migration[5.1]
  def up
     rename_table :message_forms, :forms
  end

  def down
    rename_table :forms, :message_forms
  end
end
