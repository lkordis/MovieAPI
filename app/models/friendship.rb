class Friendship < ApplicationRecord
    belongs_to :users

    self.primary_keys = :userId1_id, :userId2_id
end
