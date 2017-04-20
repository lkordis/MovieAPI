class User < ApplicationRecord
    has_many :reviews
    has_many :ratings
    has_many :comments
    has_many :movies ,:through => :seen_movies
    has_many :movies ,:through => :wished_movies
    has_many :seen_movies
    has_many :wished_movies

    has_secure_password
end
