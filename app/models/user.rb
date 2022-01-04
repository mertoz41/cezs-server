class User < ApplicationRecord
    has_secure_password
    has_one_attached :avatar
    
    has_many :userinfluences
    has_many :influencers, through: :userinfluences
    has_many :playlists, dependent: :destroy 
    
    has_many :messages, dependent: :destroy
    has_many :userchatrooms, dependent: :destroy
    has_many :chatrooms, through: :userchatrooms

    has_many :band_blocks, dependent: :destroy
    has_many :blocked_bands, through: :band_blocks

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

    has_many :account_reports, dependent: :destroy

    has_many :songfollows, dependent: :destroy
    has_many :followedsongs, through: :songfollows

    has_many :albumfollows, dependent: :destroy
    has_many :followedalbums, through: :albumfollows

    # validates :username, :password, :email, presence: true
    # validates :username, uniqueness: {message: 'already taken'}
    # validates :password, length: {minimum: 8}
    # validates :password, length: {maximum: 16}
   
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

    has_many :applauds, dependent: :destroy

    has_many :userinstruments, dependent: :destroy
    has_many :instruments, through: :userinstruments

    has_many :usergenres, dependent: :destroy
    has_many :genres, through: :usergenres

    has_many :followed_by, class_name: "Follow", foreign_key: :followed_id, dependent: :destroy
    has_many :followers, through: :followed_by, source: :follower
    has_many :follows, class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
    has_many :followeds, through: :follows, source: :followed


    has_many :blocked_by, class_name: 'UserBlock', foreign_key: :blocked_id, dependent: :destroy
    has_many :blocking_users, through: :blocked_by, source: :blockinguser
    has_many :blocked, class_name: 'UserBlock', foreign_key: :blocking_id, dependent: :destroy
    has_many :blocked_users, through: :blocked, source: :blockeduser


    def timeline
        bandpostids = []
        artistpostids = []
        songpostids = []
        albumpostids = []
        userpostids = []
        arr = []
        
        # users own posts
        arr = arr + self.posts
        # users bands posts
        if self.bands.size > 0
            lerr = self.bands.map(&:posts).flatten!
            arr = arr + lerr
        end
        
        # followed users posts
        if self.followeds.size > 0
            usersposts = self.followeds.map(&:posts).flatten!.last(5)
            arr = arr + usersposts
            userpostids = usersposts.map {|post| post.id}
        end
       
        # followed bands posts
        if self.followedbands.size > 0
            bandsposts = self.followedbands.map(&:posts).flatten!.last(5)  
            arr = arr + bandsposts
            bandpostids = bandsposts.map {|post| post.id}
        end

        # followed artists posts
        if self.followedartists.size > 0
            artistsposts = self.followedartists.map(&:posts).flatten!.last(5)    
            arr = arr + artistsposts
            artistpostids = artistsposts.map {|post| post.id}
        end

        # followed songs posts
        if self.followedsongs.size > 0
            songsposts = self.followedsongs.map(&:posts).flatten!.last(5)
            arr = arr + songsposts
            songpostids = songsposts.map {|post| post.id}
        end

        # followed albums posts
        if self.followedalbums.size > 0
        albumsposts = self.followedalbums.map(&:posts).flatten!.last(5)
        arr = arr + albumsposts
        albumpostids = albumsposts.map {|post| post.id}
        end
        unique_arr = arr.uniq
         
        return {
            timeline: unique_arr.sort_by(&:created_at).reverse, 
            bandposts: bandpostids, 
            userposts: userpostids, 
            artistposts: artistpostids, 
            albumposts: albumpostids,
            songposts: songpostids}
    end

 

    def timeline_refresh(date)
        arr = []
         # followed users posts
        if (self.followeds.size > 0)
            arr = arr + self.followeds.map(&:posts).flatten!.select {|post| post.created_at > date}
        end
         # followed bands posts
        if (self.followedbands.size > 0)
            arr = arr + self.followedbands.map(&:posts).flatten!.select {|post| post.created_at > date}
        end

        # # followed artists posts
        if (self.followedartists.size > 0)
            arr = arr +  self.followedartists.map(&:posts).flatten!.select {|post| post.created_at > date}
        end
        # # followed songs posts
        if (self.followedsongs.size > 0)
            arr = arr + self.followedsongs.map(&:posts).flatten!.select {|post| post.created_at > date}
        end
        # # followed albums posts
        if (self.followedalbums.size > 0)
            arr = arr + self.followedalbums.map(&:posts).flatten!.select {|post| post.created_at > date}
        end
        return arr.sort_by(&:created_at).reverse.take(10)
    end
end
