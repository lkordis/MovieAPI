class RemoveIdFromRatings < ActiveRecord::Migration[5.0]
  def change
    remove_column :ratings, :id, :int
    execute "ALTER TABLE ratings ADD PRIMARY KEY (user_id,movie_id);"
  end
end
