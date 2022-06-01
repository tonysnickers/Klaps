class AddColumnStepToQuizzChoice < ActiveRecord::Migration[7.0]
  def change
    add_column :quizz_choices, :step, :string, default: "initial"
  end
end
