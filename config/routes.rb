Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :house_members, only: [:show]
  resources :senators, only: [:show]
  root to: 'home#index'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/representatives/:state_abbreviation', to: 'representatives#index'
end
