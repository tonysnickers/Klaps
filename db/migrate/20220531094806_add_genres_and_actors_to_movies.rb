class AddGenresAndActorsToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :genre, :string
    add_column :movies, :actor, :string
  end
end
