class CreateMovieGenres < ActiveRecord::Migration[5.0]
  def change
    create_table :movie_genres, :id => false do |t|
      t.references :movie, index: true, foreign_key: { to_table: :movies }
      t.references :genre, index: true, foreign_key: { to_table: :genres }
      t.timestamps
    end
  end
end
