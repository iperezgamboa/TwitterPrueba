ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :username, :profile_picture
  
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :username, :profile_picture]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
   
  permit_params :username, :email, :profile_picture

  index do
		column 'Username', :username

		column 'Number of users followed' do |user|
			user.likes.count
		end
  
		column 'Tweets quantity' do |user|
			user.tweets.count
		end

		column 'Likes quantity' do |user|
			user.likes.count
		end

		column 'Cantidad de Retweets' do |user|
			arr = []
			user.tweets.each do |tweet|
				arr << tweet.tweet_id
			end
			arr.delete(nil)
			arr.length
		end


		actions
	end
	
  
end 
  

