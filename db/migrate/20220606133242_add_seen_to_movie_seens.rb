class AddSeenToMovieSeens < ActiveRecord::Migration[7.0]
  def change
    add_column :movie_seens, :seen, :boolean, default: false
  end
end
