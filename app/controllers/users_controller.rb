class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_request

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = set_user
    respond_to do |format|
      if @user
        format.json { render json: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    puts user_params
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        command = AuthenticateUser.call(params[:email], params[:password]) 
        format.json { render json: {user: @user, auth_token: command.result } }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.json { render @user, status: :ok, location: @user }
      else
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.json { head :no_content }
    end
  end

  #GET /search/users.json
  def search
    respond_to do |format|
      if logged_in?
        @user = current_user
        @prefix = params[:query]

        @usersName = User.where("lower(name) like ?","#{@prefix.downcase}%")
        @usersEmail = User.where("lower(email) like ?","#{@prefix.downcase}%")
        @usersLast = User.where("lower(last_name) like ?","#{@prefix.downcase}%")

        @users = @usersName | @usersEmail | @usersLast

        format.json {render json: @users, status: :ok}
      else
        format.json { render json: nil, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.permit(:name, :lastName, :email, :password, :user_image)
    end
end
