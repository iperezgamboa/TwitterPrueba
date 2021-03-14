class ApiController < ActionController::API
    
before_action :authenticate_user!

def create_api_tweet 
  
    @user = current_user
      if @user.present?
          @tweeet = Tweet.new(content: request.headers["X-CONTENT"], user: @user)
          if @tweeet.save
              render json: @tweeet
          else
              render json: "Tweet couldn't be saved"
          end
          else
              render json: "User not found"
      end
    end
end
