Rails.application.routes.draw do
  get 'sessions/new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/seen_movies', to: 'seen_movies#index'
  post '/seen_movies', to: 'seen_movies#create'
  delete '/seen_movies', to: 'seen_movies#destroy' 

  get '/wished_movies', to: 'wished_movies#index'
  post '/wished_movies', to: 'wished_movies#create'
  delete '/wished_movies', to: 'wished_movies#destroy'
end
