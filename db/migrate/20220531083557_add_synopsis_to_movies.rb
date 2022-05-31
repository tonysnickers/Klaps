class AddSynopsisToMovies < ActiveRecord::Migration[7.0]
  def change
    add_column :movies, :synopsis, :text
  end
end
