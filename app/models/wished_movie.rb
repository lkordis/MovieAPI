class WishedMovie < ApplicationRecord
    has_many :users, :movies
end
