class RatingsController < ApplicationController
  before_action :authenticate_request

  # GET /ratings
  # GET /ratings.json
  def index
    @ratings = Rating.all
  end

  # GET /ratings/1
  # GET /ratings/1.json
  def show
  end

  # GET /ratings/new
  def new
    @rating = Rating.new
  end

  # GET /ratings/1/edit
  def edit
  end

  # POST /ratings
  # POST /ratings.json
  def create
    respond_to do |format|
      if logged_in?
        @user = current_user
        @movie = Movie.find_or_create_by(id: params[:movie_id], title: params[:title])
        @rating = Rating.new(user_id: @user.id, movie_id: @movie.id, rating: params[:rating])

        if @rating.save
          format.json { render json: @rating }
        else
          format.json { render json: @rating.errors, status: :unprocessable_entity }
        end
      else 
        format.json { head :no_content }
      end
    end
  end

  def movie_rating
    @ratings = Rating.where(movie_id: params[:movie_id])
    @result = 0
    @ratings.each do |rating|
      puts rating.rating
      @result += rating.rating
    end
    respond_to do |format|
      if @ratings.length > 0
        @result = @result.to_f / @ratings.length.to_f
          if logged_in?
            @user = current_user
            @rating = Rating.where(user_id: @user.id, movie_id: params[:movie_id]).first
            format.json { render json: {rating: @result, user_rating: @rating} }
          else
            format.json { render json: {rating: @result} }
          end
      else
        format.json { head :no_content }
      end
    end
  end

  def user_rating
    respond_to do |format|
      if logged_in?
        @user = current_user
        @rating = Rating.where(user_id: @user.id, movie_id: params[:movie_id]).first

        format.json { render json: @rating }
      else
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ratings/1
  # PATCH/PUT /ratings/1.json
  def update
    if logged_in?
      @user = current_user
      @rating = Rating.where(user_id: @user.id, movie_id: params[:movie_id]).first
      respond_to do |format|
        if @rating.update(user_id: @user.id, movie_id: params[:movie_id], rating: params[:rating])
          format.json { render json: @rating }
        else
          format.json { render json: @rating.errors, status: :unprocessable_entity }
        end
      end
    else
      format.json { head :no_content }
    end
  end

  # DELETE /ratings/1
  # DELETE /ratings/1.json
  def destroy
    @rating.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
