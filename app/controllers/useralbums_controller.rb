class UseralbumsController < ApplicationController
    def create
        user = User.find(params[:user_id])
        album_name = params[:name]
        album_spotify_id = params[:albumSpotifyId]
        artist_name = params[:artist_name]
        artist_spotify_id = params[:artistSpotifyId]
        album = Album.find_by(spotify_id: album_spotify_id)
        if album
            # if album exists
            new_useralbum = Useralbum.create(user_id: user.id, album_id: album.id)
            render json: {album: album}
        else
            artist = Artist.find_by(spotify_id: artist_spotify_id)
            if artist
                # if artist exists
                new_album = Album.create(name: album_name, spotify_id: album_spotify_id, artist_id: artist.id)
                new_useralbum = Useralbum.create(user_id: user.id, album_id: new_album.id)
                render json: {album: new_album}

            else 
                # if artist doesnt exist
                new_artist = Artist.create(name: artist_name, spotify_id: artist_spotify_id)
                new_album = Album.create(name: album_name, spotify_id: album_spotify_id, artist_id: new_artist.id)
                new_useralbum = Useralbum.create(user_id: user.id, album_id: new_album.id)
                render json: {album: new_album}

            end
            # if album does not exist
        end



        # find album first
        # if album doesnt exist
        # find artist
        # if artist doesnt exist
        # create artist first, then album, then useralbum instance


    end
end
