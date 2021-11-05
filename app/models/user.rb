class User < ApplicationRecord
    has_secure_password
    has_one_attached :avatar
    
    has_many :userinfluences
    has_many :influencers, through: :userinfluences
    has_many :playlists, dependent: :destroy 
    
    has_many :messages, dependent: :destroy
    has_many :userchatrooms, dependent: :destroy
    has_many :chatrooms, through: :userchatrooms

    has_many :events, dependent: :destroy
    has_many :auditions, dependent: :destroy

    has_many :comment_notifications, dependent: :destroy
    has_many :follow_notifications, dependent: :destroy
    has_many :event_notifications, dependent: :destroy
    has_many :audition_notifications, dependent: :destroy
    has_many :applaud_notifications, dependent: :destroy
    has_many :playlist_notifications, dependent: :destroy
    

    has_many :bandfollows, dependent: :destroy
    has_many :followedbands, through: :bandfollows

    has_many :artistfollows, dependent: :destroy
    has_many :followedartists, through: :artistfollows

    has_many :songfollows, dependent: :destroy
    has_many :followedsongs, through: :songfollows

    has_many :albumfollows, dependent: :destroy
    has_many :followedalbums, through: :albumfollows

    
    validates :username, uniqueness: { case_sensitive: false }
    # has_one :location

    # has_many :userdescpostfeatures, dependent: :destroy
    # has_many :featureduserdescposts, through: :userdescpostfeatures

    has_many :postfeatures, dependent: :destroy
    has_many :featuredposts, through: :postfeatures

    has_many :useralbums, dependent: :destroy
    has_many :favoritealbums, through: :useralbums

    has_many :userartists, dependent: :destroy
    has_many :favoriteartists, through: :userartists

    has_many :usersongs, dependent: :destroy
    has_many :favoritesongs, through: :usersongs
    
    has_one :bio, dependent: :destroy
    has_one :userlocation, dependent: :destroy
    has_one :location, through: :userlocation
    has_one :notification_token, dependent: :destroy

    has_many :bandmembers, dependent: :destroy
    has_many :bands, through: :bandmembers

    has_many :posts, dependent: :destroy
    has_many :songs, through: :posts

    has_many :comments, dependent: :destroy

    has_many :bandpostcomments, dependent: :destroy
    has_many :userdescpostcomments, dependent: :destroy
    has_many :banddescpostcomments, dependent: :destroy




    has_many :applauds, dependent: :destroy

    has_many :userinstruments, dependent: :destroy
    has_many :instruments, through: :userinstruments

    has_many :usergenres, dependent: :destroy
    has_many :genres, through: :usergenres

    has_many :followed_by, class_name: "Follow", foreign_key: :followed_id, dependent: :destroy
    has_many :followers, through: :followed_by, source: :follower
    has_many :follows, class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
    has_many :followeds, through: :follows, source: :followed


    def timeline
        bandposts = []
        artistposts = []
        songposts = []
        albumposts = []
        userposts = []
        arr = []
        
        # users own posts
        arr = arr + self.posts.last(5)
        self.bands.each do |band|
            arr = arr + band.posts.last(5)
        end
        # followed users posts
        self.followeds.each do |user|
            posts = user.posts.last(5)
            arr = arr + posts
            ids = posts.map { |post| post.id}
            userposts = userposts + ids
        end
        # followed bands posts
        self.followedbands.each do |band|
            posts = band.posts.last(5)
            arr = arr + posts
            ids = posts.map { |post| post.id}
            bandposts = bandposts + ids
        end 
        # followed artists posts
        self.followedartists.each do |artist|
            posts = artist.posts.last(5)
            arr = arr + posts
            ids = posts.map { |post| post.id}
            artistposts = artistposts + ids
        end 
        # followed songs posts
        self.followedsongs.each do |song|
            posts = song.posts.last(5)
            arr = arr + posts
            ids = posts.map { |post| post.id}
            songposts = songposts + ids
        end
        # followed albums posts
        self.followedalbums.each do |album|
            posts = album.posts.last(5)
            arr = arr + posts
            ids = posts.map { |post| post.id}
            albumposts = albumposts + ids
        end
        unique_arr = arr.uniq
         
        return {
            timeline: unique_arr.sort_by(&:created_at).reverse.take(10), 
            bandposts: bandposts, 
            userposts: userposts, 
            artistposts: artistposts, 
            albumposts: albumposts,
            songposts: songposts}
    end

    def timeline_refresh(date)
        arr = []
         # followed users posts
         self.followeds.each do |user|
            followedposts = user.posts.where('created_at > ?', date)
            arr = arr + followedposts
        end

         # followed bands posts
         self.followedbands.each do |band|
            followedbandsposts = band.posts.where('created_at > ?', date)
            arr = arr + followedbandsposts
        end
        # followed artists posts
        self.followedartists.each do |artist|
            followedartists = artist.posts.where('created_at > ?', date)
            arr = arr + followedartists
        end 
        # followed songs posts
        self.followedsongs.each do |song|
            followedsongs = song.posts.where('created_at > ?', date)
            arr = arr + followedsongs
        end
        # followed albums posts
        self.followedalbums.each do |album|
            followedalbums = album.posts.where('created_at > ?', date)
            arr = arr + followedalbums
        end
        return arr.sort_by(&:created_at).reverse.take(10)
    end
end
