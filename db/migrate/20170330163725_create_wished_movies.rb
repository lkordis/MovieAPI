class CreateWishedMovies < ActiveRecord::Migration[5.0]
  def change
    create_table :wished_movies, :id => false do |t|
      t.references :user, index: true, foreign_key: { to_table: :users }
      t.references :movie, index: true, foreign_key: { to_table: :movies }
      t.timestamps
    end
  end
end
