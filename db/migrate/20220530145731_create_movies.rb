class CreateMovies < ActiveRecord::Migration[7.0]
  def change
    create_table :movies do |t|
      t.string :name
      t.integer :duration
      t.integer :rating
      t.integer :year
      t.string :country
      t.string :keyword
      t.string :restriction
      t.string :poster
      t.string :platform

      t.timestamps
    end
  end
end
