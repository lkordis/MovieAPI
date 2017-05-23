class MoviesController < ApplicationController
    skip_before_filter :verify_authenticity_token

    def user_movies
        respond_to do |format|
            if logged_in?
                @user = current_user
                @seen_movies = SeenMovie.where(user_id: @user.id)
                @wished_movies = WishedMovie.where(user_id: @user.id)
                @movies1 = Array.new
                @movies2 = Array.new

                if !@seen_movies.empty?
                    @seen_movies.each do |seen_movie|
                        @movie = Movie.find(seen_movie.movie_id)
                        @movies1 << @movie
                    end
                end

                if !@wished_movies.empty?
                    @wished_movies.each do |wished_movie|
                        @movie = Movie.find(wished_movie.movie_id)
                        @movies2 << @movie
                    end
                end

                @movies = @movies1 | @movies2

                format.json {render json: @movies}
            else
                format.json { render json: nil, status: :unprocessable_entity }
            end
        end
    end
end
