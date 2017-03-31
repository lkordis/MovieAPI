class Movie < ApplicationRecord
    has_many :reviews
    has_many :ratings
    has_many :seen_movies
    has_many :wished_movies
    has_many :genres, through: :movie_genres 
end
