class RemoveSeenFromMovieSeens < ActiveRecord::Migration[7.0]
  def change
    remove_column :movie_seens, :seen
  end
end
