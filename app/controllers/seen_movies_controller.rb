class SeenMoviesController < ApplicationController
    skip_before_filter :verify_authenticity_token

    def index
        respond_to do |format|
            if logged_in?
                @user = current_user
                puts @user.name
                @seen_movies = SeenMovie.where(user_id: @user.id)
                format.json { render json: @seen_movies }
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
                @movie = Movie.find_or_create_by(seen_movies_params)
                puts @movie.id
                @seen_movie = SeenMovie.new(user_id: @user.id, movie_id: @movie.id)

                if @seen_movie.save
                    format.json { render json: @seen_movie }
                else
                    format.json { render json: @seen_movie.errors, status: :unprocessable_entity }
                end
                
            else
                format.json { render json: nil, status: :unprocessable_entity }
            end
        end
    end

    private
        def seen_movies_params
            params.permit(:title, :id, :poster_path)
        end
end
