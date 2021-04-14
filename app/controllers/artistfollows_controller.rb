class ArtistfollowsController < ApplicationController
    def create
        byebug
        new_follow = Artistfollow.create(user_id: params[:user_id], artist_id: params[:artist_id]) 
        render json: {new_follow: new_follow}
    end 

    def destroy
        artis_follow = Artistfollow.find_by(user_id: params[:user_id], artist_id: params[:artist_id])
        artis_follow.destroy
        render json: {message: 'succezs'}

    end
    def newartist
        @artist = Artist.create(name: params[:name], spotify_id: params[:id], avatar: params[:avatar])
        artis_follow = Artistfollow.create(user_id: params[:user_id], artist_id: @artist.id)
        render json: {artist: ArtistSerializer.new(@artist)}

    end
end
