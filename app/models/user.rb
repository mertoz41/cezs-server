
class User < ApplicationRecord
    has_secure_password
    has_one_attached :avatar
    
    has_many :notifications, dependent: :destroy
    has_many :action_notifications, class_name: "Notification", foreign_key: :action_user_id, dependent: :destroy
    has_many :messages, dependent: :destroy
    has_many :userchatrooms
    has_many :chatrooms, through: :userchatrooms, dependent: :destroy
    
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
    has_many :reports_given, class_name: "Report", foreign_key: :reporting_user_id, dependent: :destroy
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
    has_many :bands, through: :bandmembers, dependent: :destroy

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
            usersposts = self.followeds.map(&:posts).flatten!.select {|post| post.reports.size < 1 }
            arr = arr + usersposts
        end
       
        # followed bands posts
        if self.followedbands.size > 0
            bandsposts = self.followedbands.map(&:posts).flatten!.select {|post| post.reports.size < 1}
            arr = arr + bandsposts
        end

        # followed artists posts
        if self.followedartists.size > 0
            artistsposts = self.followedartists.map(&:posts).flatten!.select {|post| post.reports.size < 1}      
            arr = arr + artistsposts
        end

        # followed songs posts
        if self.followedsongs.size > 0
            songsposts = self.followedsongs.map(&:posts).flatten!.select {|post| post.reports.size < 1}.last(5)
            arr = arr + songsposts
        end
        return arr.uniq.sort_by(&:created_at).reverse.first(8)
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

    def update(params)
        if params[:username]
            found = User.find_by(username: params[:username])
            if found
                render json: {error: 'This name is taken.'}
            else
                self.update_column 'username', params[:username]
            end
        end


        if params[:name]
            self.update_column 'name', params[:name]
        end
        if params[:email]
            self.update_column 'email', params[:email]
        end
        if params[:bio]
            self.update_column 'bio', params[:bio]
        end

        if params[:location]
            if self.userlocation
                old_location = self.userlocation
                old_location.destroy
            end
            location = Location.find_by(city: params[:location]["city"])
            if location
                new_user_location = Userlocation.create(user_id: self.id, location_id: location.id)
            else
                new_location = Location.create(city: params[:location]["city"], latitude: params[:location]["latitude"], longitude: params[:location]["longitude"])
                new_user_location = Userlocation.create(user_id: self.id, location_id: new_location.id)
            end
        end

        if params[:instruments]
            params[:instruments].each do |inst|
                instrument = Instrument.find_or_create_by(name: inst)
                user_instrument = Userinstrument.create(user_id: self.id, instrument_id: instrument.id)
            end
        end

        if params[:genres]
            params[:genres].each do |genr|
                genre = Genre.find_or_create_by(name: genr)
                user_genre = Usergenre.create(user_id: self.id, genre_id: genre.id)
            end
        end

        if params[:favoriteartists]
            params[:favoriteartists].each do |fav_artist|
                artist = Artist.find_or_create_by(name: fav_artist)
                user_artist = Userartist.create(user_id: self.id, artist_id: artist.id)
            end
        end
        if params[:favoritesongs]
            params[:favoritesongs].each do |fav_song|
                artist = Artist.find_or_create_by(name: fav_song["artist_name"])
                song = Song.find_or_create_by(name: fav_song["name"], artist_id: artist.id)
                user_song = Usersong.create(user_id: self.id, song_id: song.id)
            end
        end

        if params[:removedInstruments]
            params[:removedInstruments].each do |inst|
                old_instrument = Userinstrument.find_by(user_id: self.id, instrument_id: inst)
                old_instrument.destroy
            end
        end

        if params[:removedGenres]
            params[:removedGenres].each do |genr|
                old_genr = Usergenre.find_by(user_id: self.id, genre_id: genr)
                old_genr.destroy
            end
        end

        if params[:removedArtists]
            params[:removedArtists].each do |artis|
                old_art = Userartist.find_by(user_id: self.id, artist_id: artis)
                old_art.destroy
            end
        end

        if params[:removedSongs]
            params[:removedSongs].each do |song|
                old_song = Usersong.find_by(user_id: self.id, song_id: song)
                old_song.destroy
            end
        end
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
