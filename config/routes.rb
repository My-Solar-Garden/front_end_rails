Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  
  get '/auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure,' to: redirect('/')

  get '/privacy', to: 'privacy#index'
end
