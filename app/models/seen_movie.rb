class SeenMovie < ApplicationRecord
    belongs_to :users
    belongs_to :movies

    self.primary_keys = :user_id, :movie_id
end
