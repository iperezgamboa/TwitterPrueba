Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :tweets do
     resources :likes 
     post :retweet
  end

  post 'user/:user_id', to: 'friends#create', as: 'friend_create'
  delete 'user/:user_id', to: 'friends#destroy', as: 'friend_destroy'
  
  get 'api/news', to: 'tweets#news'
  get 'api/:fecha1/:fecha2', to: 'tweets#date'
  post 'api/tweets/:content', to: 'tweets#create_api_tweet'
  

  

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

   root "tweets#index"
   
end
