class User < ApplicationRecord
    has_secure_password
    has_one_attached :avatar

    has_many :userinfluences
    has_many :influencers, through: :userinfluences
    
    # has_and_belongs_to_many :chatrooms, dependent: :destroy
    has_many :messages, dependent: :destroy
    has_many :userchatrooms, dependent: :destroy
    has_many :chatrooms, through: :userchatrooms

    has_many :userevents, dependent: :destroy


    has_many :bandfollows, dependent: :destroy
    has_many :followedbands, through: :bandfollows

    has_many :artistfollows, dependent: :destroy
    has_many :followedartists, through: :artistfollows

    has_many :songfollows, dependent: :destroy
    has_many :followedsongs, through: :songfollows


    validates :username, uniqueness: { case_sensitive: false }
    # has_one :location

    has_many :userdescpostfeatures, dependent: :destroy
    has_many :featureduserdescposts, through: :userdescpostfeatures

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
    

    has_many :bandmembers, dependent: :destroy
    has_many :bands, through: :bandmembers

    has_many :posts, dependent: :destroy
    has_many :songs, through: :posts

    has_many :comments, dependent: :destroy

    has_many :bandpostcomments, dependent: :destroy
    has_many :userdescpostcomments, dependent: :destroy
    has_many :banddescpostcomments, dependent: :destroy




    has_many :shares, dependent: :destroy
    has_many :bandpostshares, dependent: :destroy
    has_many :banddescpostshares, dependent: :destroy
    has_many :userdescpostshares, dependent: :destroy

    # has_many :requests, dependent: :destroy
    # has_many :responses, dependent: :destroy
    has_many :userdescposts, dependent: :destroy

    has_many :userinstruments, dependent: :destroy
    has_many :instruments, through: :userinstruments

    has_many :followed_by, class_name: "Follow", foreign_key: :followed_id, dependent: :destroy
    has_many :followers, through: :followed_by, source: :follower
    has_many :follows, class_name: "Follow", foreign_key: :follower_id, dependent: :destroy
    has_many :followeds, through: :follows, source: :followed


    def timeline
        arr = []
        # users own posts
        self.posts.each do |post|
            arr.push(post)
        end 
        # users bands posts
        self.bands.each do |band|
            band.posts.each do |bandpost|
                arr.push(bandpost)
            end
        end
        # followed users posts
        self.followeds.each do |user|
            user.posts.each do |post|
            arr.push(post)
            end 
        end
        # followed bands posts
        self.followedbands.each do |band|
            band.posts.each do |bandpost|
                arr.push(bandpost)
            end
        end 
        # followed artists posts
        self.followedartists.each do |artist|
            artist.posts.each do |post|
                if !arr.include?(post)
                arr.push(post)
                end
            end
        end 
        # followed songs posts
        self.followedsongs.each do |song|
            song.posts.each do |post|
                if !arr.include?(post)
                arr.push(post)
                end
            end
        end
        return arr.sort_by(&:created_at).reverse.take(10)
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
        return arr.sort_by(&:created_at).reverse.take(10)
    end
end
