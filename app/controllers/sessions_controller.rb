class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user && user.authenticate(params[:password])
      # Log the user in and redirect to the user's show page.
      log_in user
    else
      # Create an error message.
      render 'new'
    end
  end

  def destroy
    log_out
  end
end