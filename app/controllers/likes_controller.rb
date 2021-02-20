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

<% pre_like = tweeet.likes.find { |like| like.user_id == current_user.id if user_signed_in? } %>
    <% if pre_like %>
    <%= link_to image_tag('like.png', size: "20x20"), like_path(pre_like.id), method: :delete %>
    <% else %>
    <%= link_to image_tag('dislike.png', size: "20x20"), likes_path(tweeet.id), method: :post %>
    <% end %>
    <%= tweeet.likes.count %>
</div>