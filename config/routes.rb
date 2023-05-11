Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :chatrooms
  resources :messages
  resources :bios
  resources :locations
  resources :userinstruments
  resources :songs
  resources :shares
  resources :posts
  resources :instruments
  resources :genres
  resources :comments
  resources :artists
  resources :users
  resources :bands
  resources :bandbios
  resources :bandlocations
  resources :bandmembers
  resources :usersongs
  resources :userartists
  resources :events
  resources :albums

  mount ActionCable.server => '/cable'

  post '/login', to: 'auth#create'
  get '/check', to: 'auth#check'
  post '/avatar', to: 'users#avatar'
  post '/picture', to: 'bands#picture'
  post '/usersearch', to: 'users#searching'
  post '/followedusers', to: 'follows#search_followed_users'
  post '/songsearch', to: 'songs#searching'
  post '/artistsearch', to: 'artists#searching'
  post '/bandsearch', to: 'bands#searching'
  post '/filter', to: 'posts#filter'
  post '/instrumentfilter', to: 'instruments#filter'
  post '/instrumentsearch', to: 'instruments#searching'
  post '/deleteuserinstrument', to: 'userinstruments#delete'
  post '/createusergenre', to: 'genres#createusergenre'
  post '/deleteusergenre', to: 'genres#deleteusergenre'
  post '/createbandgenre', to: 'genres#createbandgenre'
  post '/deletebandgenre', to: 'genres#deletebandgenre'

  get '/artistfollowers/:id', to: 'artists#artistfollowers'
  get '/artistfavorites/:id', to: 'artists#artistfavorites'

  get '/getfollows/:id', to: 'follows#follows'
  get '/getfollowers/:id', to: 'follows#followers'
  delete '/unfollow/:id', to: 'follows#unfollow'
  get '/follow/:id', to: 'follows#follow'


  post '/passwordcheck', to: 'users#passwordcheck'
  post '/changepassword', to: 'users#changepassword'
  
  delete '/artistunfollow/:id', to: 'artists#artistunfollow'
  post '/artistfollow', to: 'artists#artistfollow'
  get '/artistinfluences/:id', to: 'artists#influences'
  post  '/deleteuserartist', to: 'userartists#delete'
  post '/usersfiltersearch', to: 'users#filter_search'
  post '/bandsfiltersearch', to: 'bands#filter_search'
  post '/postsfiltersearch', to: 'posts#filter_search'

  post '/deleteusersong', to: 'usersongs#delete'
  
  get '/albumsongs/:id', to: 'albums#albumsongs'
  get '/albumfavorites/:id', to: 'albums#albumfavorites'
  delete '/albumunfollow/:id', to: 'albums#albumunfollow'

  post '/requestpasswordreset', to: "auth#requestpasswordreset"
  post '/resetpassword', to: "auth#resetpassword"
  post '/countview/:id', to: 'posts#createview'
  post '/musicposts', to: 'posts#musicposts'
  get '/filterlocations', to: 'locations#filterlocations'
  
  post '/reportpost/:id', to: 'reports#post_report'
  post '/reportuser/:id', to: 'reports#user_report'
  post '/reportband/:id', to: 'reports#band_report'
  post '/reportcomment/:id', to: 'reports#comment_report'
  post '/reportevent/:id', to: 'reports#event_report'

  get '/songfollowers/:id', to: 'songs#songfollowers'
  get '/songfavorites/:id', to: 'songs#songfavorites'
  post '/songfollow', to: 'songs#songfollow'
  delete '/songunfollow/:id', to: 'songs#songunfollow'

  get '/exploredata', to: 'search#exploredata'
  get '/instrumentsgenres', to: 'search#get_instruments_genres'
  post '/applaudpost', to: 'applauds#applaudpost'
  delete '/unapplaudpost/:id', to: 'applauds#unapplaudpost'

  post '/instrumentsearch', to: 'instruments#instrumentsearch'
  post '/genresearch', to: 'genres#genresearch'
  post '/timeline', to: 'timeline#user_timeline'
  post '/olderposts', to: 'timeline#older_posts'
  post '/usertoken', to: 'users#usertoken'
  get '/experimentnotification', to: 'notifications#experiment'
  post '/marknotifications', to: 'notifications#marknotifications'
  post '/seemessages', to: 'chatrooms#seemessages'

  get '/seegignoti/:id', to: 'notifications#seegignoti'
  get '/seefollownoti/:id', to: 'notifications#seefollowoti'
  get '/seeauditnoti/:id', to: 'notifications#seeauditnoti'
  get '/seeapplaudnoti/:id', to: 'notifications#seeapplaudnoti'
  get '/seecommentnoti/:id', to: 'notifications#seecommentnoti'

  delete '/bandunfollow/:id', to: 'bandfollows#unfollow'
  get '/bandfollowers/:id', to: 'bandfollows#bandfollowers'
  get '/bandfollow/:id', to: 'bandfollows#follow'

  get '/oldermessages/:id', to: 'messages#oldermessages'

  post '/block_account', to: 'userblocks#create'
  get '/blockedaccounts', to: 'userblocks#blockedaccounts'
  delete '/unblockuser/:id', to: 'userblocks#unblockuser'

  post '/blockband', to: 'userblocks#blockband'
  delete '/unblockband/:id', to: 'userblocks#unblockband'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
