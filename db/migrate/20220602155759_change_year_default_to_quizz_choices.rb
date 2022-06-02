class ChangeYearDefaultToQuizzChoices < ActiveRecord::Migration[7.0]
  def change
    change_column :quizz_choices, :start_year, :integer, default: 1960
    change_column :quizz_choices, :end_year, :integer, default: 2022
  end
end
