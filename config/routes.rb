Rails.application.routes.draw do
  resources :chatrooms
  resources :messages
  resources :bios
  resources :locations
  resources :userinstruments
  resources :userinfluences
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
  resources :bands
  resources :bandposts
  resources :bandfollows
  resources :bandbios
  resources :bandlocations
  resources :bandmembers
  resources :artistfollows
  resources :userevents
  resources :bandevents
  resources :banddescposts
  resources :userdescposts
  resources :bandpostcomments 
  resources :banddescpostcomments
  resources :userdescpostcomments 

  mount ActionCable.server => '/cable'

  # post '/experiment', to: 'users#experiment'
  get '/experiment', to: 'users#experiment'
  post '/login', to: 'auth#create'
  post '/check', to: 'auth#check'
  post '/avatar', to: 'users#avatar'
  post '/picture', to: 'bands#picture'
  post '/usersearch', to: 'users#searching'
  post '/songsearch', to: 'songs#searching'
  post '/artistsearch', to: 'artists#searching'
  post '/bandsearch', to: 'bands#searching'
  post '/filter', to: 'posts#filter'
  post '/deleteinfluence', to: 'userinfluences#delete'
  post '/instrumentsearch', to: 'instruments#searching'
  post '/deleteuserinstrument', to: 'userinstruments#delete'
  post '/artistcheck', to: 'artists#check'
  get '/getfollows/:id', to: 'follows#follows'
  get '/getfollowers/:id', to: 'follows#followers'
  get '/influences/:id', to: 'artists#influences'
  post '/removemember', to: 'bandmembers#removemember'
  post '/artistunfollow', to: 'artistfollows#destroy'
  post '/eventbydate', to: 'userevents#bydate'
  post '/newartistfollow', to: 'artistfollows#newartist'
  post '/bandpostshares', to: 'bandposts#share'
  post '/banddescpostshares', to: 'banddescposts#share'
  post '/userdescpostshares', to: 'userdescposts#share'
  delete '/unsharebandpost/:id', to: 'bandposts#unshare'
  delete '/unsharebanddescpost/:id', to: 'banddescposts#unshare'
  delete '/unshareuserdescpost/:id', to: 'userdescposts#unshare'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
