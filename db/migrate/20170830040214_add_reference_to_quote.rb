class AddReferenceToQuote < ActiveRecord::Migration[5.1]
  def change
    add_reference :quotes, :message, foreign_key: true
  end
end
