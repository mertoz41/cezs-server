Rails.application.routes.draw do
  resources :users
  # post '/experiment', to: 'users#experiment'
  get '/experiment', to: 'users#experiment'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
