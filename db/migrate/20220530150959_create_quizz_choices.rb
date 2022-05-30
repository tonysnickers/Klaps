class CreateQuizzChoices < ActiveRecord::Migration[7.0]
  def change
    create_table :quizz_choices do |t|
      t.string :genre
      t.string :actor
      t.string :keyword
      t.integer :duration
      t.references :group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
