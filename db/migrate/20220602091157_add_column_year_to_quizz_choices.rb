class AddColumnYearToQuizzChoices < ActiveRecord::Migration[7.0]
  def change
    add_column :quizz_choices, :start_year, :integer
    add_column :quizz_choices, :end_year, :integer
  end
end
