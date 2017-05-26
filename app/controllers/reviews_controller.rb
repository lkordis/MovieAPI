class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_request, only: [:create, :update, :destroy, :index, :users_reviews]

  # GET /reviews
  # GET /reviews.json
  def index
    @user = current_user
    @friendships1 = Friendship.where(userId1_id: @user.id)
    @friendships2 = Friendship.where(userId2_id: @user.id)

    @users1 = Array.new
    @users2 = Array.new
    @users = Array.new

    @friendships1.each do |friendship|
      @u = User.find(friendship.userId2_id)
      @users1 << @u
    end

    @friendships2.each do |friendship|
      @u = User.find(friendship.userId1_id)
      @users2 << @u
    end                

    @users = @users1 | @users2 
    @users << @user
    puts @users      
    @reviews = Array.new

    @users.each do |user|
      @r = Review.where(user_id: user.id)      
      @reviews |= @r
    end

    respond_to do |format|
      format.json { render json: @reviews }
    end
  end

  # GET /user_reviews.json
  def users_reviews
    @user = current_user
    @reviews = Review.where(user_id: @user.id)

    respond_to do |format|
      format.json { render json: @reviews }
    end
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    @review = set_review
    respond_to do |format|
      if @review
        format.json { render json: @review }
      else
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @user = current_user
    @movie = Movie.find_or_create_by(id: params[:movie_id])
    @review = Review.new(user_id: @user.id, text: params[:text], movie_id: params[:movie_id], image_url: params[:image_url])

    respond_to do |format|
      if @review.save
        format.json { render json: @review }
      else
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.json { render json: @review }
      else
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.permit(:movie_id, :text, :image_url)
    end
end
