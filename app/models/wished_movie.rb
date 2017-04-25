class WishedMovie < ApplicationRecord
    has_many :users
    has_many :movies

    self.primary_keys = :user_id, :movie_id
end
