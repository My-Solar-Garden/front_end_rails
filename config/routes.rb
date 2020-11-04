Rails.application.routes.draw do
  root to: 'welcome#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get "/logout", to: "sessions#destroy"
  get '/privacy', to: 'privacy#index'
  get "/dashboard", to: "dashboard#show"

  resources :gardens, except: [:destroy]
  delete 'gardens/:id', to: 'gardens#destroy', as: :garden_destroy
  get 'gardens/:id', to: 'gardens#show', as: :garden_show

  get "/learn_more", to: "learn_more#show"
  get '/profile', to: 'users#show'

  resources :users, except: [:index, :show]
  resources :sensors, except: [:index]
  get "/learn_more", to: "learn_more#show"
  get "/logout", to: "sessions#destroy"

  get '/gardens/:garden_id/sensors', to: 'sensors#new'
  post '/gardens/:garden_id/sensors', to: 'sensors#create'
  delete '/gardens/:garden_id/sensors/:id', to: 'sensors#destroy'
  get '/gardens/:garden_id/sensors/:id', to: 'sensors#show'

  get '/gardens/:garden_id/plants', to: 'plants#new'
  get '/gardens/:garden_id/plants/:id', to: 'plants#show'

  namespace :gardens do
    post '/:id/plants/:plant_id', to: 'plants#create'
  end

  namespace :plants do
    get '/search', to: 'search#index'
  end
  resources :plants, except: [:index]
end
