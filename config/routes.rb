Rails.application.routes.draw do
  resources :groups do 
    get '/users', to: 'groups#group_users'
  end 
  resources :users do 
    get '/friends', to: 'users#user_friends'
    get '/groups', to: 'users#user_groups'
  end 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
