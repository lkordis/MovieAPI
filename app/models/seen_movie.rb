class SeenMovie < ApplicationRecord
    has_many :users, :movies
end
