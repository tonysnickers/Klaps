class AddMovieOrderToGroupUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :group_users, :movie_order, :string, array: true, default: []
  end
end
