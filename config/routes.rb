require 'sidekiq/web'
Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resources :chatrooms
  resources :applauds
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
  resources :bandmembers
  resources :usersongs
  resources :userartists
  resources :reports
  resources :events
  resources :albums
  resources :bandfollows
  resources :follows
  resources :bandgenres
  resources :userblocks

  mount ActionCable.server => '/cable'
  mount Sidekiq::Web => '/sidekiq'
  post '/login', to: 'auth#create'
  get '/check', to: 'auth#check'
  post '/avatar', to: 'users#avatar'
  post '/picture', to: 'bands#picture'

  post '/usersearch', to: 'users#searching'
  post '/followedusers', to: 'follows#search_followed_users'
  post '/songsearch', to: 'songs#searching'
  post '/artistsearch', to: 'artists#searching'
  post '/bandsearch', to: 'bands#searching'
  post '/instrumentsearch', to: 'instruments#searching'

  post '/filter', to: 'posts#filter'
  post '/deleteuserinstrument', to: 'userinstruments#delete'
  post '/createusergenre', to: 'genres#createusergenre'
  post '/deleteusergenre', to: 'genres#deleteusergenre'
 
  get '/artistfollowers/:id', to: 'artists#followers'
  get '/artistfavorites/:id', to: 'artists#favorites'

  get '/getfollows/:id', to: 'follows#follows'
  get '/getfollowers/:id', to: 'follows#followers'

  post '/passwordcheck', to: 'users#passwordcheck'
  post '/changepassword', to: 'users#changepassword'
  
  delete '/artistunfollow/:id', to: 'artists#unfollow'
  post '/artistfollow', to: 'artists#follow'
    
  # get '/albumsongs/:id', to: 'albums#albumsongs'
  # get '/albumfavorites/:id', to: 'albums#albumfavorites'
  # delete '/albumunfollow/:id', to: 'albums#albumunfollow'

  post '/requestpasswordreset', to: "auth#requestpasswordreset"
  post '/resetpassword', to: "auth#resetpassword"
  post '/countview/:id', to: 'posts#createview'
  post '/musicposts', to: 'posts#musicposts'
  get '/filterlocations', to: 'locations#filterlocations'
  
  post '/songfollow', to: 'songs#songfollow'
  delete '/songunfollow/:id', to: 'songs#songunfollow'

  get '/exploredata', to: 'search#exploredata'
  get '/instrumentsgenres', to: 'search#get_instruments_genres'

  post '/instrumentsearch', to: 'instruments#instrumentsearch'
  post '/genresearch', to: 'genres#search'
  get '/timeline', to: 'timeline#get_timeline'
  post '/refreshtimeline', to: 'timeline#refresh_timeline'
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

  post '/usersfiltersearch', to: 'users#filter_search'
  post '/bandsfiltersearch', to: 'bands#filter_search'
  post '/postsfiltersearch', to: 'posts#filter_search'
  
  get '/oldermessages/:id', to: 'messages#oldermessages'

  post '/block_account', to: 'userblocks#create'

  delete '/unblockband/:id', to: 'userblocks#unblockband'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
