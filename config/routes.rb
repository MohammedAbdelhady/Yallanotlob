Rails.application.routes.draw do
  delete '/friendships', to: 'friendships#unfriend'
  delete '/group_users', to: 'group_users#removeFriendFromGroup'
  
  resources :friendships
  resources :group_users

  resources :groups do 
    get '/users', to: 'groups#group_users'
  end 

  resources :users do 
    
    resources :orders, only: [:index,:update,:create,:destroy]  , on: :member do
    resources :order_items , only: [:index,:create,:destroy] 
    end

    get '/friends', to: 'users#user_friends'
    get '/groups', to: 'users#user_groups'

  end 
      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
