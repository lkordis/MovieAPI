class AddPrimaryKeysToTables < ActiveRecord::Migration[5.0]
  def change
    execute "ALTER TABLE credits ADD PRIMARY KEY (movie_id,cast_id,cast_role_id);"
  end
end
