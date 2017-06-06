class RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :edit, :update, :destroy]
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
        @rating = Rating.new(user_id: @user.id, movie_id: params[:movie_id], rating: params[:rating])

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
    @result = @result / @ratings.length
    respond_to do |format|
      format.json { render json: @result }
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
    respond_to do |format|
      if @rating.update(user_id: @user.id, movie_id: params[:movie_id], rating: params[:rating])
        format.json { render :show, status: :ok, location: @rating }
      else
        format.json { render json: @rating.errors, status: :unprocessable_entity }
      end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rating_params
      params.fetch(:rating, {})
    end
end
