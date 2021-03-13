Rails.application.routes.draw do
  get 'api/create_api_tweet'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :tweets do
     resources :likes 
     post :retweet
  end

  post 'user/:user_id', to: 'friends#create', as: 'friend_create'
  delete 'user/:user_id', to: 'friends#destroy', as: 'friend_destroy'
  get 'user/:id', to: 'users#show', as: 'profile_user'

  get 'api/news', to: 'tweets#news'
  get 'api/:fecha1/:fecha2', to: 'tweets#date'
  post 'api/tweets', to: 'api#create_api_tweet'
  
   

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   root "tweets#index"
   
end
