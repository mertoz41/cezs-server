class UsersongsController < ApplicationController
    def create
        
        @song = Song.find_or_create_by(artist_id: params[:artist_id], name: params[:name], id: params[:id])
        user_song = Usersong.create(user_id: logged_in_user.id, song_id: @song.id)
        render json: {song: SongSerializer.new(@song)}
    end

    def update
        old_favorite = Usersong.find_by(song_id: params[:id], user_id: logged_in_user.id)
        old_favorite.destroy
        artist = Artist.find_or_create_by(name: params[:artist_name])
        @song = Song.find_or_create_by(name: params[:name], artist_id: artist.id)
        new_favorite = Usersong.create(song_id: @song.id, user_id: logged_in_user.id)
        render json: {song: SongSerializer.new(@song)}
    end

    def destroy
        song = Song.find(params[:id])
        usersong = Usersong.find_by(user_id: logged_in_user.id, song_id: song.id)
        usersong.destroy
        render json: {message: 'favorite song successfully deleted.'}
    end
end
