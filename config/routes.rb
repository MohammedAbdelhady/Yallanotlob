Rails.application.routes.draw do
  resources :groups,  except: [ :user_groups ] do 
    get '/users', to: 'users#group_users'
  end 
  resources :users do 
    get '/groups', to: 'users#user_groups'
  end 
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
