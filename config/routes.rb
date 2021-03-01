Rails.application.routes.draw do
  resources :locations
  resources :userinstruments
  resources :songs
  resources :shares
  resources :responses
  resources :requests
  resources :posts
  resources :instruments
  resources :genres
  resources :follows
  resources :comments
  resources :artists
  resources :users
  # post '/experiment', to: 'users#experiment'
  get '/experiment', to: 'users#experiment'
  post '/login', to: 'auth#create'
  post '/check', to: 'auth#check'
  post '/avatar', to: 'users#avatar'
  post '/usersearch', to: 'users#searching'
  post '/songsearch', to: 'songs#searching'
  post '/artistsearch', to: 'artists#searching'
  post '/filter', to: 'posts#filter'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
