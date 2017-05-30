class DeleteMovieGenres < ActiveRecord::Migration[5.0]
  def change
    drop_table :movie_genres
    drop_table :genres
  end
end
