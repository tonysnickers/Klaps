class ChangeGenreTypeToArray < ActiveRecord::Migration[7.0]
  def change
    change_column :quizz_choices, :genre, "varchar[] USING (string_to_array(genre, ','))"
    change_column :quizz_choices, :actor, "varchar[] USING (string_to_array(actor, ','))"
    change_column :quizz_choices, :keyword, "varchar[] USING (string_to_array(keyword, ','))"
  end
end
