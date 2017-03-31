class AddForeignKeysToRatings < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :ratings, :users
    add_foreign_key :ratings, :movies
  end
end
