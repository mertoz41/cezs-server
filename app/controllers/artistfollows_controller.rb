class ArtistfollowsController < ApplicationController
    def create
        artist = Artist.find_or_create_by(name: params[:artist_name], spotify_id: params[:artistSpotifyId])
        new_follow = Artistfollow.create(user_id: params[:user_id], artist_id: artist.id) 
        render json: {new_follow: artist.id}
    end 

    def destroy
        artis_follow = Artistfollow.find_by(user_id: params[:user_id], artist_id: params[:artist_id])
        artis_follow.destroy
        render json: {message: 'succezs'}

    end
  
end
