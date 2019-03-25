Rails.application.routes.draw do
  delete '/friendships', to: 'friendships#unfriend'
  delete '/group_users', to: 'group_users#removeFriendFromGroup'
  post '/login', to: 'users#login'
  
  resources :friendships
  resources :group_users

  resources :groups do 
    get '/users', to: 'groups#group_users'
  end 

  resources :users do 
    
    resources :orders, only: [:index,:create]  , on: :member do
    resources :order_items , only: [:create] 
    end

    get '/friends', to: 'users#user_friends'
    get '/groups', to: 'users#user_groups'

  end

  get '/orders/:id/invited', to: "orders#get_invited_friends"  
  get '/orders/:id/order_items', to: "order_items#get_order_details"
  put '/orders/:id/finished', to: "orders#finish_order"
  put 'users/:user_id/orders/:id/join', to: "orders#join_order"
  delete '/orders/:id', to: "orders#destroy"
  delete '/orders/:order_id/order_items/:id', to: "order_items#destroy"
  delete '/orders/:order_id/remove/:user_id', to: "orders#remove_invitation"

      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
