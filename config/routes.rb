Rails.application.routes.draw do
  root to: 'welcome#index'
  resources :profile, only: [:show, :destroy]
  resources :dashboard, only: [:show]
  resources :gardens, except: [:index]
  resources :plants, except: [:index]
  resources :sensors, except: [:index]
  resources :learn_more, only: [:show]
end
