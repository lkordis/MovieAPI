class User < ApplicationRecord
    has_many :reviews, :ratings, :comments, :seen_movies, :wished_movies
end
