Rails.application.routes.draw do
  root to: 'welcome#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get "/logout", to: "sessions#destroy"
  get '/privacy', to: 'privacy#index'
  get "/dashboard", to: "dashboard#show"
  get "/learn_more", to: "learn_more#show"
  get '/profile', to: 'users#show'

  resources :users, except: [:index, :show]
  namespace :gardens do 
    post '/:id/plants/:plant_id', to: 'plants#create'
  end
  resources :gardens, except: [:index]
  resources :sensors, except: [:index]
  namespace :plants do
    get '/search', to: 'search#index'
  end
  resources :plants, except: [:index]
end
