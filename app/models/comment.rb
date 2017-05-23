class Comment < ApplicationRecord
    belongs_to :review
    belongs_to :user

    self.primary_keys = :user_id, :review_id
end
