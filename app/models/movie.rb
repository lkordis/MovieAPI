class Movie < ApplicationRecord
    has_many :reviews, :ratings, :seen_movies, :wished_movies
    has_many :genres, through: :movie_genres 
end
