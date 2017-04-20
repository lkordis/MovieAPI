class WishedMoviesController < ApplicationController
    skip_before_filter :verify_authenticity_token

    def index
        respond_to do |format|
            if logged_in?
                @user = current_user
                @wished_movies = WishedMovie.where(user_id: @user.id)
                format.json { render json: @wished_movies }
            else
                format.json { render json: nil, status: :unprocessable_entity }
            end
        end
    end

    def create
        respond_to do |format|
            if logged_in?
                @user = current_user
                puts @user.id
                @movie = Movie.find_or_create_by(wished_movies_params)
                puts @movie.id
                @wished_movie = WishedMovie.new(user_id: @user.id, movie_id: @movie.id)

                if @wished_movie.save
                    format.json { render json: @wished_movie }
                else
                    format.json { render json: @wished_movie.errors, status: :unprocessable_entity }
                end
                
            else
                format.json { render json: nil, status: :unprocessable_entity }
            end
        end
    end

    private
        def wished_movies_params
            params.permit(:title, :id)
        end
end
