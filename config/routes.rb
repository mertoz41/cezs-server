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
  # resources :follows
  resources :comments
  resources :artists
  resources :users
  resources :bands
  resources :bandfollows
  resources :bandbios
  resources :bandlocations
  resources :bandmembers
  # resources :artistfollows
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

  get '/userposts/:id', to: 'users#userposts'
  get '/bandposts/:id', to: 'bands#bandposts'

  post '/artistcheck', to: 'artists#check'
  get '/artistfollowers/:id', to: 'artists#artistfollowers'
  get '/artistfavorites/:id', to: 'artists#artistfavorites'

  get '/getfollows/:id', to: 'follows#follows'
  get '/getfollowers/:id', to: 'follows#followers'
  delete '/unfollow/:id', to: 'follows#unfollow'
  get '/follow/:id', to: 'follows#follow'




  
  delete '/artistunfollow/:id', to: 'artists#artistunfollow'
  post '/artistfollow', to: 'artists#artistfollow'
  get '/artistinfluences/:id', to: 'artists#influences'
  post '/removemember', to: 'bandmembers#removemember'
  post '/eventbydate', to: 'userevents#bydate'
  post  '/deleteuserartist', to: 'userartists#delete'
  post '/userfiltersearch', to: 'users#filtersearch'
  post '/bandfiltersearch', to: 'bands#filtersearch'
  post '/deleteusersong', to: 'usersongs#delete'


  get '/albumfollowers/:id', to: 'albums#albumfollowers'
  post '/deleteuseralbum', to: 'useralbums#delete'
  get '/albumcheck/:id', to: 'albums#albumcheck'
  get '/albumsongs/:id', to: 'albums#albumsongs'
  get '/albumfavorites/:id', to: 'albums#albumfavorites'
  post '/albumfollow', to: 'albums#albumfollow'
  delete '/albumunfollow/:id', to: 'albums#albumunfollow'

  post '/postviewcount', to: 'posts#createview'
  get '/filterlocations', to: 'locations#filterlocations'
  
  
  get '/songcheck/:id', to: 'songs#check'
  get '/songfollowers/:id', to: 'songs#songfollowers'
  get '/songfavorites/:id', to: 'songs#songfavorites'
  post '/songfollow', to: 'songs#songfollow'
  delete '/songunfollow/:id', to: 'songs#songunfollow'


  post '/postreport', to: 'reports#postreport'
  post '/commentreport', to: 'reports#commentreport'
  post '/userreport', to: 'reports#userreport'
  post '/bandreport', to: 'reports#bandreport'

  post '/newplaylist', to: 'playlists#newplaylist'
  post '/addtoplaylist', to: 'playlists#addtoplaylist'
  get '/playlists/:id', to: 'playlists#show'
  post '/removefromplaylist', to: 'playlists#removefromplaylist'
  post '/deleteplaylist', to: 'playlists#deleteplaylist'

  get '/exploredata', to: 'search#exploredata'

  post '/applaudpost', to: 'applauds#applaudpost'
  post '/unapplaudpost', to: 'applauds#unapplaudpost'


  post '/instrumentsearch', to: 'instruments#instrumentsearch'
  post '/genresearch', to: 'genres#genresearch'
  post '/timeline', to: 'timeline#user_timeline'
  post '/userdescposts', to: 'posts#createuserdescpost'
  post '/bandposts', to: 'posts#createbandpost'
  post '/banddescposts', to: 'posts#createbanddescposts'
  post '/usertoken', to: 'users#usertoken'
  get '/experimentnotification', to: 'notifications#experiment'
  post '/marknotifications', to: 'notifications#marknotifications'
  post '/seemessages', to: 'chatrooms#seemessages'
  post '/userevent', to: 'events#userevent'
  post '/bandevent', to: 'events#bandevent'
  get '/events', to: 'events#index'
  get '/events/:id', to: 'events#show'


  get '/seegignoti/:id', to: 'notifications#seegignoti'
  get '/seefollownoti/:id', to: 'notifications#seefollowoti'
  get '/seeauditnoti/:id', to: 'notifications#seeauditnoti'
  get '/seeplaylistnoti/:id', to: 'notifications#seeplaylistnoti'
  get '/seeapplaudnoti/:id', to: 'notifications#seeapplaudnoti'
  get '/seecommentnoti/:id', to: 'notifications#seecommentnoti'


  get '/bandunfollow/:id', to: 'bandfollows#unfollow'
  get '/bandfollowers/:id', to: 'bandfollows#bandfollowers'
  get '/bandfollow/:id', to: 'bandfollows#follow'


  get '/oldermessages/:id', to: 'messages#oldermessages'
  post '/createuseraudition', to: 'auditions#createuseraudition'
  post '/createbandaudition', to: 'auditions#createbandaudition'
  get '/locationauditions/:id', to: 'auditions#locationauditions'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
