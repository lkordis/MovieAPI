class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  def new
    respond_to do |format|
        if logged_in?
          format.json { render json: current_user }
        else
          format.json { render json: nil, status: :unprocessable_entity }
        end
      end
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      # Log the user in and redirect to the user's show page.
      log_in user

      respond_to do |format|
        format.json {render json: current_user}
      end
    else
      # Create an error message.
    end
  end

  def destroy
    log_out
  end
end