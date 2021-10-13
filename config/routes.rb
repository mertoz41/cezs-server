Rails.application.routes.draw do
  resources :chatrooms
  resources :messages
  resources :bios
  resources :locations
  resources :userinstruments
  resources :userinfluences
  resources :songs
  resources :shares
  resources :posts
  resources :instruments
  resources :genres
  resources :follows
  resources :comments
  resources :artists
  resources :users
  resources :bands
  resources :bandfollows
  resources :bandbios
  resources :bandlocations
  resources :bandmembers
  resources :artistfollows
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
  post '/createusergenre', to: 'genres#createusergenre'
  post '/deleteusergenre', to: 'genres#deleteusergenre'
  post '/createbandgenre', to: 'genres#createbandgenre'
  post '/deletebandgenre', to: 'genres#deletebandgenre'
  post '/artistcheck', to: 'artists#check'
  get '/getfollows/:id', to: 'follows#follows'
  get '/getfollowers/:id', to: 'follows#followers'
  get '/influences/:id', to: 'artists#influences'
  post '/removemember', to: 'bandmembers#removemember'
  post '/artistunfollow', to: 'artistfollows#destroy'
  post '/eventbydate', to: 'userevents#bydate'
  post  '/deleteuserartist', to: 'userartists#delete'
  post '/userfiltersearch', to: 'users#filtersearch'
  post '/bandfiltersearch', to: 'bands#filtersearch'
  post '/deleteusersong', to: 'usersongs#delete'
  post '/deleteuseralbum', to: 'useralbums#delete'
  get '/albumcheck/:id', to: 'albums#albumcheck'
  get '/songcheck/:id', to: 'songs#check'
  post '/postviewcount', to: 'posts#createview'
  get '/filterlocations', to: 'locations#filterlocations'
  post '/songfollow', to: 'songs#songfollow'
  post '/songunfollow', to: 'songs#songunfollow'
  post '/instrumentsearch', to: 'instruments#instrumentsearch'
  post '/genresearch', to: 'genres#genresearch'
  post '/timeline', to: 'timeline#user_timeline'
  get '/bandfollowers/:id', to: 'bandfollows#bandfollowers'
  post '/userdescposts', to: 'posts#createuserdescpost'
  post '/bandposts', to: 'posts#createbandpost'
  post '/banddescposts', to: 'posts#createbanddescposts'
  get '/albumsongs/:id', to: 'albums#albumsongs'
  post '/usertoken', to: 'users#usertoken'
  get '/experimentnotification', to: 'notifications#experiment'
  post '/unfollow', to: 'follows#unfollow'
  post '/marknotifications', to: 'notifications#marknotifications'
  post '/seemessages', to: 'chatrooms#seemessages'
  post '/userevent', to: 'events#userevent'
  post '/bandevent', to: 'events#bandevent'
  get '/events', to: 'events#index'
  get '/events/:id', to: 'events#show'
  get '/seegignoti/:id', to: 'events#seenotification'
  get '/seefollownoti/:id', to: 'follows#seenotification'
  get '/seesharenoti/:id', to: 'shares#seenotification'
  get '/seecommentnoti/:id', to: 'comments#seenotification'
  post '/bandunfollow', to: 'bandfollows#unfollow'
  get '/oldermessages/:id', to: 'messages#oldermessages'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
