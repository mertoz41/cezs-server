class PostsController < ApplicationController

    def create
        user_id = params[:user_id].to_i
        # instrument_id = params[:instrument_id].to_i
        genre_id = params[:genre_id].to_i
        artist_name = params[:artist_name]
        artist_spotify_id = params[:artist_spotify_id]
        song_spotify_id = params[:song_spotify_id]
        song_name = params[:song_name]
        album_name = params[:album_name]
        album_spotify_id = params[:album_spotify_id]

        features = JSON.parse params[:features]

        
         

        # find artist by artist name and spotify id
        # if artist found use it for post creation
        artist = Artist.find_by(name: artist_name, spotify_id: artist_spotify_id)
        if artist
            artist_album = Album.find_by(spotify_id: album_spotify_id, artist_id: artist.id, name: album_name)
            if artist_album
                # byebug
                # if album exists, use it for song creation
                song = Song.find_or_create_by(name: song_name, artist_id: artist.id, spotify_id: song_spotify_id, album_id: artist_album.id)
                @post = Post.create(user_id: user_id, artist_id: artist.id, song_id: song.id, genre_id: genre_id)
                if features.length > 0
                    features.each do |id|
                        Postfeature.create(user_id: id, post_id: @post.id)
                    end
                end
                if params[:instruments].kind_of?(Array)
                    selected_instruments = JSON.parse params[:instruments]
                    selected_instruments.each do |id|
                        Postinstrument.create(instrument_id: id, post_id: @post.id)
                    end
                else
                    instrument = Instrument.find_or_create_by(name: params[:instruments])
                    Postinstrument.create(instrument_id: instrument.id, post_id: @post.id)
                end
               
                # create the post first
                # then create postfeature and postinstruments instances
                @post.clip.attach(params[:clip])
                @post.thumbnail.attach(params[:thumbnail])
                render json: @post, serializer: PostSerializer
            else
                new_artist_album = Album.create(name: album_name, spotify_id: album_spotify_id, artist_id: artist.id)
                new_song = Song.create(name: song_name, artist_id: artist.id, album_id: new_artist_album.id, spotify_id: song_spotify_id)
                @post = Post.create(user_id: user_id, artist_id: artist.id, song_id: new_song.id, genre_id: genre_id)
                if features.length > 0
                    features.each do |id|
                        Postfeature.create(user_id: id, post_id: @post.id)
                    end

                end
                if params[:instruments].kind_of?(Array)
                    selected_instruments = JSON.parse params[:instruments]
                    selected_instruments.each do |id|
                        Postinstrument.create(instrument_id: id, post_id: @post.id)
                    end
                else
                    instrument = Instrument.find_or_create_by(name: params[:instruments])
                    Postinstrument.create(instrument_id: instrument.id, post_id: @post.id)
                end
                @post.clip.attach(params[:clip])
                @post.thumbnail.attach(params[:thumbnail])
                render json: @post, serializer: PostSerializer
            end
            # if artist exists, find album by artist_id, album_spotify_id, and album_name
            # if not create album then find song
        else
        # if not create an artist instance
        # then create post instance
            new_artist = Artist.create(name: artist_name, spotify_id: artist_spotify_id)
            new_album = Album.create(name: album_name, spotify_id: album_spotify_id, artist_id: new_artist.id)
            song = Song.find_or_create_by(name: song_name, artist_id: new_artist.id, spotify_id: song_spotify_id, album_id: new_album.id)
            @post = Post.create(user_id: user_id, artist_id: new_artist.id, song_id: song.id, genre_id: genre_id)
            if features.length > 0
                features.each do |id|
                    Postfeature.create(user_id: id, post_id: @post.id)
                end

            end
            if params[:instruments].kind_of?(Array)
                selected_instruments = JSON.parse params[:instruments]
                selected_instruments.each do |id|
                    Postinstrument.create(instrument_id: id, post_id: @post.id)
                end
            else
                instrument = Instrument.find_or_create_by(name: params[:instruments])
                Postinstrument.create(instrument_id: instrument.id, post_id: @post.id)
            end
            @post.clip.attach(params[:clip])
            @post.thumbnail.attach(params[:thumbnail])
            render json: @post, serializer: PostSerializer
        end

    end 

    def filter
        instruments = params[:selected_instruments]
        genres = params[:selected_genres]
        states = params[:selected_states]
        @posts = []
        @userdescposts = []
        @bandposts = []
        @banddescposts = []
        if instruments.length > 0
            instruments.each do |inst|
                instrument = Instrument.find(inst)
                instrument.posts.each do |post|
                    if !@posts.include?(post)
                        @posts.push(post)
                    end
                end
                instrument.userdescposts.each do |post|
                    if !@userdescposts.include?(post)
                        @userdescposts.push(post)
                    end
                        
                end
                instrument.bandposts.each do |post|
                    if !@bandposts.include?(post)
                        @bandposts.push(post)
                    end
                end
                instrument.banddescposts.each do |post|
                    if !@banddescposts.include?(post)
                        @banddescposts.push(post)
                    end
                end
            end
        end

        if genres.length > 0
            genres.each do |genr|
                genre = Genre.find(genr)
                genre.posts.each do |post|
                    if !@posts.include?(post)
                        @posts.push(post)
                    end
                end
                genre.userdescposts.each do |post|
                    if !@userdescposts.include?(post)
                        @userdescposts.push(post)
                    end
                        
                end
                genre.bandposts.each do |post|
                    if !@bandposts.include?(post)
                        @bandposts.push(post)
                    end
                end
                genre.banddescposts.each do |post|
                    if !@banddescposts.include?(post)
                        @banddescposts.push(post)
                    end
                end
            end
        end


        if states.length > 0
            states.each do |state|
                users = User.joins(:location).merge(Location.where("city like?", "%#{state}%"))
                bands = Band.joins(:location).merge(Location.where("city like?", "%#{state}%"))
                users.each do |user|

                    user.posts.each do |post|
                        if !@posts.include?(post)
                            @posts.push(post)
                        end
                    end

                    user.userdescposts.each do |post|
                        if !@userdescposts.include?(post)
                            @userdescposts.push(post)
                        end
                    end

                end

                bands.each do |band|

                    band.bandposts.each do |post|
                        if !@bandposts.include?(post)
                            @bandposts.push(post)
                        end
                    end

                    band.banddescposts.each do |post|
                        if !@banddescposts.include?(post)
                            @banddescposts.push(post)
                        end
                    end
                end
            end

                

        end
        render json: {posts: ActiveModel::Serializer::CollectionSerializer.new(@posts, each_serializer: PostSerializer), bandposts: ActiveModel::Serializer::CollectionSerializer.new(@bandposts, each_serializer: BandpostSerializer), userdescposts: ActiveModel::Serializer::CollectionSerializer.new(@userdescposts, each_serializer: UserdescpostSerializer), banddescposts: ActiveModel::Serializer::CollectionSerializer.new(@banddescposts, each_serializer: BanddescpostSerializer)}
    end

    def createview
        # byebug
        user = User.find(params[:user_id])
        post = Post.find(params[:post_id])
        Postview.create(user_id: user.id, post_id: post.id)
        render json: {message: 'view counted'}
    end

    def destroy
        post = Post.find(params[:id])
        song = Song.find(post.song_id)

        post.destroy
        if song.bandposts.length == 0 && song.posts.length == 0
            song.destroy
        end
        render json: {message: 'post deleted.'}
    end

end
