class WishedMoviesController < ApplicationController
    skip_before_filter :verify_authenticity_token

    def index
        respond_to do |format|
            if logged_in?
                @user = current_user
                puts @user.name
                @wished_movies = WishedMovie.where(user_id: @user.id)
                @movies = Array.new

                @wished_movies.each do |wished_movie|
                    @movie = Movie.find(wished_movie.movie_id)
                    @movies << @movie
                end

                format.json { render json: @movies }
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
            params.permit(:title, :id, :poster_path)
        end
end
