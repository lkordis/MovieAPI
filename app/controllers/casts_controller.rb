class CastsController < ApplicationController
    skip_before_filter :verify_authenticity_token

    def search
        respond_to do |format|
            if logged_in?
                @response = Array.new
                @user = current_user
                @prefix = params[:query]
                @names = Cast.where("lower(name) like ?","#{@prefix.downcase}%")
                @lastNames = Cast.where('lower(last_name) like ?',"#{@prefix.downcase}%") #postgres nije case-sensitive, peder

                @seen_movies = SeenMovie.where(user_id: @user.id)
                @wished_movies = WishedMovie.where(user_id: @user.id)

                @casts = @names | @lastNames

                @casts.each do |cast|
                    @movies = Set.new
                    @jobs = Set.new
                    @hash = Hash.new
                    @hash[:id] = cast.id
                    @hash[:name] = cast.name
                    @hash[:lastName] = cast.last_name
                    @hash[:profile_path] = cast.profile_path

                    @user_movies = Set.new

                    @credits = Credit.where(cast_id: cast.id)
                    @credits.each do |credit|
                        @movie = Movie.find(credit.movie_id)
                        @job = CastRole.find(credit.cast_roles_id)
                        @movies << @movie
                        @jobs << @job.role
                    end

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

                    @hash[:known_for] = @user_movies
                    @hash[:jobs] = @jobs
                    @response << @hash
                end

                format.json { render json: @response }
            else
                format.json { render json: nil, status: :unprocessable_entity }
            end
        end
    end
end
