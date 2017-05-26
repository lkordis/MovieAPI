class SeenMoviesController < ApplicationController
    skip_before_filter :verify_authenticity_token

    Tmdb::Api.key("0649ca7815178f68273bfb149e7716cc")

    def index
        respond_to do |format|
            if logged_in?
                @user = current_user
                puts @user.name
                @seen_movies = SeenMovie.where(user_id: @user.id)
                @movies = Array.new

                @seen_movies.each do |seen_movie|
                    @movie = Movie.find(seen_movie.movie_id)
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
                @movie = Movie.find_or_create_by(seen_movies_params)

                @seen_movie = SeenMovie.new(user_id: @user.id, movie_id: @movie.id)

                if @seen_movie.save
                    format.json { render json: @seen_movie }
                else
                    format.json { render json: @seen_movie.errors, status: :unprocessable_entity }
                end

                @credits = Tmdb::Movie.credits(@movie.id)
                @actors = @credits['cast']

                if !Credit.exists?(movie_id: @movie.id)
                    @actors.each do |actor|
                        @nameArray = actor['name'].split(" ")
                        @name = @nameArray[0]
                        @lastName = ""

                        if @nameArray.length > 3
                            @name += " " + @nameArray[1]
                            @lastName = @nameArray[2]
                        else
                            @lastName = @nameArray[1]
                        end

                        @cast = Cast.find_or_create_by(id: actor['id'], name: @name, last_name: @lastName)
                        Credit.create(movie_id: @movie.id, cast_id: @cast.id)
                    end
                end
                
            else
                format.json { render json: nil, status: :unprocessable_entity }
            end
        end
    end

    def search
        respond_to do |format|
            if logged_in?
                @user = current_user
                @prefix = params[:query]
                @movies = Movie.where("lower(title) like ?","#{@prefix.downcase}%")

                @seen_movies = SeenMovie.where(user_id: @user.id)
                @user_movies = Array.new

                @seen_movies.each do |seen_movie|
                    @movie = Movie.find(seen_movie.movie_id)

                    if @movies.include? @movie
                        @user_movies << @movie
                    end
                end

                format.json { render json: @user_movies }
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
