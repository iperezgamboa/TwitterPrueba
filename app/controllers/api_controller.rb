class ApiController < ActionController::API
  def create_api_tweet 
    
        @user = User.find_by(email: request.headers["X-EMAIL"])
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
