class DropMovieSeens < ActiveRecord::Migration[7.0]
  def change
    drop_table :movie_seens
  end
end
