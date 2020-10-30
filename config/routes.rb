Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/privacy', to: 'privacy#index'
  
  get '/dashboard', to: 'dashboard#show'
  
  resources :gardens, expect: :index
end
