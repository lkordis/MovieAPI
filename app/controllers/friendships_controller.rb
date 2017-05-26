class FriendshipsController < ApplicationController
    skip_before_filter :verify_authenticity_token

    def index
        respond_to do |format|
            if logged_in?
                @user = current_user
            
                @friendships1 = Friendship.where(userId1_id: @user.id)
                @friendships2 = Friendship.where(userId2_id: @user.id)
                
                @users1 = Array.new
                @users2 = Array.new

                @friendships1.each do |friendship|
                    @u = User.find(friendship.userId2_id)
                    @users1 << @u
                end

                @friendships2.each do |friendship|
                    @u = User.find(friendship.userId1_id)
                    @users2 << @u
                end                

                @users = @users1 | @users2                

                format.json { render json: @users }
            else
                format.json { render json: nil, status: :unprocessable_entity }
            end
        end
    end


    def recommend
        respond_to do |format|
            if logged_in?
                @curr_user = current_user
                @my_movies = user_movies(@curr_user.id)

                @users = User.all
                @recommended = Set.new

                @users.each do |user|
                    @common_movies = user_movies(user.id) & @my_movies
                    if @common_movies.length >= 3 && @recommended.length < 10 && user != @curr_user
                        @friends = filter_friends
                        unless @friends.any? {|f| f.id == user.id }
                            @recommended << user
                        end
                    end
                end

                format.json { render json: @recommended }
                
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
                @friend = User.find(params[:user_id])
                puts @friend.id

                @friendship = Friendship.new(userId1_id: @user.id, userId2_id: @friend.id)

                if @friendship.save
                    format.json { render json: @friendship }
                else
                    format.json { render json: @friendship.errors, status: :unprocessable_entity }
                end
                
            else
                format.json { render json: nil, status: :unprocessable_entity }
            end
        end
    end

    private
        def seen_movies_params
            params.permit(:user_id)
        end

        def filter_friends
            @user = current_user
            @friendships1 = Friendship.where(userId1_id: @user.id)
            @friendships2 = Friendship.where(userId2_id: @user.id)
                
            @usersFriends = Set.new

            @friendships1.each do |friendship|
                @u = User.find(friendship.userId2_id)
                @usersFriends << @u
            end

            @friendships2.each do |friendship|
                @u = User.find(friendship.userId1_id)
                @usersFriends << @u
            end                

            return @usersFriends
        end

        def user_movies(user_id)
            @seen_movies = SeenMovie.where(user_id: user_id)
            @wished_movies = WishedMovie.where(user_id: user_id)
            @movies1 = Array.new
            @movies2 = Array.new

            @seen_movies.each do |seen_movie|
                @movie = Movie.find(seen_movie.movie_id)
                @movies1 << @movie
            end

            @wished_movies.each do |wished_movie|
                @movie = Movie.find(wished_movie.movie_id)
                @movies2 << @movie
            end

            return @movies1 | @movies2
        end
end
