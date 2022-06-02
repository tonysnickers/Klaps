class ChangeDurationToQuizzChoices < ActiveRecord::Migration[7.0]
  def change
    change_column :quizz_choices, :duration, :integer, default: 180
  end
end
