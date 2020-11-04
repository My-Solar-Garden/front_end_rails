Rails.application.routes.draw do
  root to: 'welcome#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get "/logout", to: "sessions#destroy"
  get '/privacy', to: 'privacy#index'
  get "/dashboard", to: "dashboard#show"

  resources :gardens

  get "/learn_more", to: "learn_more#show"
  get '/profile', to: 'users#show'

  resources :users, except: [:index, :show]
  # resources :gardens, except: [:index] do
  #   resources :sensors, only: [:destroy]
  #   require "pry"; binding.pry
  # end
  resources :plants, except: [:index]
  resources :sensors, except: [:index]
  get "/learn_more", to: "learn_more#show"
  get "/logout", to: "sessions#destroy"
  # namespace :gardens do
    get '/gardens/:garden_id/sensors', to: 'sensors#new'
    post '/gardens/:garden_id/sensors', to: 'sensors#create'
    delete '/gardens/:garden_id/sensors/:id', to: 'sensors#destroy'
  # end
end
