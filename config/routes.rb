Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :representatives, only: [:show]
  resources :senators, only: [:show]
end
