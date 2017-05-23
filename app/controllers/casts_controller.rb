class CastsController < ApplicationController
    skip_before_filter :verify_authenticity_token

    def search
        respond_to do |format|
            if logged_in?
                @user = current_user
                @prefix = params[:query]
                @names = Cast.where("lower(name) like ?","#{@prefix.downcase}%")
                @lastNames = Cast.where("lower(lastName) like ?","#{@prefix.downcase}%")

                @casts = @names | @lastNames
                @movies = Set.new
                @casts.each do |cast|
                    @credits = Credit.where(cast_id: cast.id)
                    @credits.each do |credit|
                        @movie = Movie.find(credit.movie_id)
                        @movies << @movie
                    end
                end

                @seen_movies = SeenMovie.where(user_id: @user.id)
                @wished_movies = WishedMovie.where(user_id: @user.id)
                @user_movies = Set.new

                if !@seen_movies.empty?
                    @seen_movies.each do |seen_movie|
                        @movie = Movie.find(seen_movie.movie_id)
                        if @movies.include? @movie
                            @user_movies << @movie
                        end
                    end
                end

                if !@wished_movies.empty?
                    @wished_movies.each do |wished_movie|
                        @movie = Movie.find(wished_movie.movie_id)
                        if @movies.include? @movie
                            @user_movies << @movie
                        end
                    end
                end

                format.json { render json: @user_movies }
            else
                format.json { render json: nil, status: :unprocessable_entity }
            end
        end
    end
end
