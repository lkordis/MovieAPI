class AuthenticationController < ApplicationController
    skip_before_action :authenticate_request 
    
    def authenticate 
        command = AuthenticateUser.call(params[:email], params[:password]) 
        
        if command.success? 
            render json: { auth_token: command.result, user: current_user } 
        else 
            render json: { error: command.errors, tu_si: "haha" }, status: :unauthorized 
        end 
    end
end