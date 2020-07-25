Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'home#index'
  get '/representatives/:state_abbreviation', to: 'representatives#index'
  post '/senators/:id/favorites', to: 'senator_favorites#create'
  post '/house_members/:id/favorites', to: 'house_members_favorites#create'
end
