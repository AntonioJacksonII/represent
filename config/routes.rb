Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :house_members, only: [:show]
  resources :senators, only: [:show]
  root to: 'home#index'
  get '/representatives/:state_abbreviation', to: 'representatives#index'
  post '/senators/:id/favorites', to: 'senator_favorites#create'
  delete '/senators/:id/favorites', to: 'senator_favorites#destroy'
  delete '/house_members/:id/favorites', to: 'house_members_favorites#destroy'
  post '/house_members/:id/favorites', to: 'house_members_favorites#create'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/representatives/:state_abbreviation', to: 'representatives#index'
  get '/dashboard', to: 'dashboard#show'
  get '/bills', to: 'bills#index'
end
