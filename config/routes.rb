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
  # resources :bandposts
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
  resources :usersongs
  resources :userartists
  resources :useralbums

  mount ActionCable.server => '/cable'

  # post '/experiment', to: 'users#experiment'
  get '/experiment', to: 'users#experiment'
  post '/login', to: 'auth#create'
  get '/check', to: 'auth#check'
  post '/avatar', to: 'users#avatar'
  post '/picture', to: 'bands#picture'
  post '/usersearch', to: 'users#searching'
  post '/songsearch', to: 'songs#searching'
  post '/artistsearch', to: 'artists#searching'
  post '/bandsearch', to: 'bands#searching'
  post '/filter', to: 'posts#filter'
  post '/instrumentfilter', to: 'instruments#filter'
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
  post '/bandpostshares', to: 'bandposts#share'
  post '/banddescpostshares', to: 'banddescposts#share'
  post '/userdescpostshares', to: 'userdescposts#share'
  delete '/unsharebandpost/:id', to: 'bandposts#unshare'
  delete '/unsharebanddescpost/:id', to: 'banddescposts#unshare'
  delete '/unshareuserdescpost/:id', to: 'userdescposts#unshare'
  post  '/deleteuserartist', to: 'userartists#delete'
  post '/deleteusersong', to: 'usersongs#delete'
  post '/deleteuseralbum', to: 'useralbums#delete'
  get '/albumcheck/:id', to: 'albums#albumcheck'
  get '/songcheck/:id', to: 'songs#check'
  post '/postviewcount', to: 'posts#createview'
  post '/bandpostviewcount', to: 'bandposts#createview'
  post '/descpostviewcount', to: 'userdescposts#createview'
  post '/banddescpostviewcount', to: 'banddescposts#createview'
  get '/filterlocations', to: 'locations#filterlocations'
  post '/songfollow', to: 'songs#songfollow'
  post '/songunfollow', to: 'songs#songunfollow'
  post '/instrumentsearch', to: 'instruments#instrumentsearch'
  post '/genresearch', to: 'genres#genresearch'
  post '/timeline', to: 'timeline#user_timeline'
  get '/bandfollowers/:id', to: 'bandfollows#bandfollowers'
  post '/userdescpost', to: 'posts#createuserdescpost'
  post '/bandposts', to: 'posts#createbandpost'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
