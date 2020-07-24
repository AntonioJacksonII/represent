Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/representatives/:state_abbreviation', to: 'representatives#index'

  # get '/house_members/:id'
  # get '/senators/:id'
end
