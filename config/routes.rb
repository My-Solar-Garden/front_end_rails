Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/privacy', to: 'privacy#index'
  resources :users, except: [:index]
  get "/dashboard", to: "dashboard#show"
  resources :gardens, except: [:index]
  resources :plants, except: [:index]
  resources :sensors, except: [:index]
  get "/learn_more", to: "learn_more#show"
  get "/logout", to: "sessions#destroy"
end
