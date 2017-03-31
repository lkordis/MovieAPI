class Comment < ApplicationRecord
    belongs_to :review, :user
end
