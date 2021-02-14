class LikesController < ApplicationController
    before_action :find_tweet
    before_action :find_like, only: [:destroy]

    def create
        if user_signed_in?
            @tweet.likes.create(user_id: current_user.id)
            redirect_to root_path
        else
            redirect_to root_path, alert: 'for like an user, you must sign in'
        end
    end

    def destroy
        if already_liked?
            @like.destroy
            redirect_to root_path
        end
    end

    private 

end
