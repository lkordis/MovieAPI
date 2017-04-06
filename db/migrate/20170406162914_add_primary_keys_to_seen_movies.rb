class AddPrimaryKeysToSeenMovies < ActiveRecord::Migration[5.0]
  def change
    execute "ALTER TABLE seen_movies ADD PRIMARY KEY (user_id,movie_id);"
  end
end
