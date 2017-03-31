class AddForeignKeysToReviews < ActiveRecord::Migration[5.0]
  def change
    add_foreign_key :reviews, :users
    add_foreign_key :reviews, :movies
  end
end
