class AddSentColumnToQuizzChoices < ActiveRecord::Migration[7.0]
  def change
    add_column :quizz_choices, :sent, :boolean, default: false
  end
end
