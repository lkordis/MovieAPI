class WishedMovie < ApplicationRecord
    has_many :users
    has_many :movies
end
