
class User < ApplicationRecord
    has_secure_password
    has_one_attached :avatar
    
    has_many :notifications
    has_many :messages, dependent: :destroy
    has_many :userchatrooms, dependent: :destroy
    has_many :chatrooms, through: :userchatrooms
    
    # users that blocked logged_in_user
    has_many :blocked_by, class_name: 'BlockedAccount', foreign_key: :blocked_user_id, dependent: :destroy
    has_many :blocking_users, through: :blocked_by, source: :blocking_user
    # users logged_in_user blocked
    has_many :userblock, class_name: "BlockedAccount", foreign_key: :blocking_user_id, dependent: :destroy
    has_many :blocked_users, through: :userblock, source: :blocked_user
    # bands logged_in_user blocked
    has_many :bandblock, class_name: "BlockedAccount", foreign_key: :blocking_user_id, dependent: :destroy
    has_many :blocked_bands, through: :bandblock, source: :blocked_band
    
    has_many :events, dependent: :destroy
    has_many :reports, dependent: :destroy
    has_many :bandfollows, dependent: :destroy
    has_many :followedbands, through: :bandfollows

    has_many :artistfollows, dependent: :destroy
    has_many :followedartists, through: :artistfollows

    has_many :songfollows, dependent: :destroy
    has_many :followedsongs, through: :songfollows

    has_many :userartists, dependent: :destroy
    has_many :favoriteartists, through: :userartists

    has_many :usersongs, dependent: :destroy
    has_many :favoritesongs, through: :usersongs
    
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



    def timeline
        bandpostids = []
        artistpostids = []
        songpostids = []
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
            # userpostids = usersposts.map {|post| post.id}
        end
       
        # followed bands posts
        if self.followedbands.size > 0
            bandsposts = self.followedbands.map(&:posts).flatten!.last(5)  
            arr = arr + bandsposts
            # bandpostids = bandsposts.map {|post| post.id}
        end

        # followed artists posts
        if self.followedartists.size > 0
            artistsposts = self.followedartists.map(&:posts).flatten!.last(5)    
            arr = arr + artistsposts
            # artistpostids = artistsposts.map {|post| post.id}
        end

        # followed songs posts
        if self.followedsongs.size > 0
            songsposts = self.followedsongs.map(&:posts).flatten!.last(5)
            arr = arr + songsposts
            songpostids = songsposts.map {|post| post.id}
        end

        # filtered = arr.select {|post| post.post_reports.size == 0}
        unique_arr = arr.uniq
        return unique_arr.sort_by(&:created_at).reverse.first(8)
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
     
        return arr.sort_by(&:created_at).reverse.take(10)
    end

    def get_older_posts(date)
        arr = []
        arr = arr + self.posts.select {|post| post.created_at <= date}
        if self.bands.size > 0
            arr = arr +  self.bands.map(&:posts).flatten!.select {|post| post.created_at <= date}
        end
        if self.followeds.size > 0
            arr = arr +  self.followeds.map(&:posts).flatten!.select {|post| post.created_at <= date}.last(5)
        end
        
        # followed bands posts
        if self.followedbands.size > 0
            arr = arr +  self.followedbands.map(&:posts).flatten!.select {|post| post.created_at <= date}.last(5)  
            # bandpostids = bandsposts.map {|post| post.id}
        end

        # followed artists posts
        if self.followedartists.size > 0
            arr = arr +  self.followedartists.map(&:posts).flatten!.select {|post| post.created_at <= date}.last(5)    
            # artistpostids = artistsposts.map {|post| post.id}
        end

        # followed songs posts
        if self.followedsongs.size > 0
            arr = arr +  self.followedsongs.map(&:posts).flatten!.select {|post| post.created_at <= date}.last(5)

        end
        unique_arr = arr.uniq
        return unique_arr.sort_by(&:created_at).reverse.first(6)
    end

    def generate_password_token!
        self.reset_token = generate_token
        self.reset_sent_at = Time.now.utc
        save!
       end
       
       def password_token_valid?
        (self.reset_sent_at + 4.hours) > Time.now.utc
       end
       
       def reset_password!(password)
        self.reset_token = nil
        self.password = password
        save!
       end
       
       private
       
       def generate_token
        SecureRandom.hex(10)
       end
end
