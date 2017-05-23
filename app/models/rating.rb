class Rating < ApplicationRecord
    belongs_to :review
    belongs_to :user
    
    self.primary_keys = :user_id, :movie_id
end
