Rails.application.routes.draw do

  
  resources :groups do 
    get '/users', to: 'groups#group_users'
  end 
  resources :users do 
    get '/groups', to: 'users#user_groups'
  end 

  resources :users do
    resources :orders, only: [:index,:update,:create,:destroy]  , on: :member do
      resources :order_items , only: [:index,:create,:destroy] 
    end
  end  
      # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
