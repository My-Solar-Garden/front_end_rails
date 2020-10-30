Rails.application.routes.draw do
  root to: 'welcome#index'
  get '/privacy', to: 'privacy#index'
  get "/users", to: "users#show"
  resources :user, only: [:show, :update, :destroy]
  get "/dashboard", to: "dashboard#show"
  resources :dashboard, only: [:show]
  resources :gardens, except: [:index]
  resources :plants, except: [:index]
  resources :sensors, except: [:index]
  get "/learn_more", to: "learn_more#show"
  resources :learn_more, only: [:show]
  get "/logout", to: "sessions#destroy"
end
