class AddKeyWordToAnswersAndQuestions < ActiveRecord::Migration[5.1]
  def change
    add_column :questions, :keyword, :string
    add_column :answers, :keyword, :string
  end
end
