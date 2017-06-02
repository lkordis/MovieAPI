Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resources :reviews
  resources :comments

  get '/login',   to: 'sessions#new'
  get '/user_reviews', to: 'reviews#users_reviews'

  get '/seen_movies', to: 'seen_movies#index'
  post '/seen_movies', to: 'seen_movies#create'
  delete '/seen_movies', to: 'seen_movies#destroy'
  get '/search/seen_movies', to: 'seen_movies#search'
  get '/show/seen_movies', to: 'seen_movies#show'

  get '/wished_movies', to: 'wished_movies#index'
  post '/wished_movies', to: 'wished_movies#create'
  delete '/wished_movies', to: 'wished_movies#destroy'
  get '/search/wished_movies', to: 'wished_movies#search'
  get '/show/wished_movies', to: 'wished_movies#show'

  post '/login', to: 'authentication#authenticate'

  get '/user_movies', to: 'movies#user_movies'

  get '/followers', to: 'friendships#followers'
  get '/following', to: 'friendships#following'
  get '/recommend_followers', to: 'friendships#recommend'
  post '/followers', to: 'friendships#create'
  delete '/followers', to: 'friendships#destroy'

  get '/search/people', to: 'casts#search'
  get '/search/users', to: 'users#search'

end
