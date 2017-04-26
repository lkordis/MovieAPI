class MoviesController < ApplicationController
    skip_before_filter :verify_authenticity_token

    def user_movies
        if logged_in?
            @user = current_user
            @seen_movies = SeenMovie.where(user_id: @user.id)
            @wished_movies = WishedMovie.where(user_id: @user.id)
            @movies = @seen_movies | @wished_movies

            render json: @movies
        else
            render json: nil, status: :unprocessable_entity
        end
    end
end
