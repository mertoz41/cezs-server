class BandpostsController < ApplicationController
    def create
        band_id = params[:band_id].to_i
        artist_name = params[:artist_name]
        artist_id = params[:artist_id]
        song_name = params[:song_name]
        instruments = JSON.parse params[:instruments]
        artist = Artist.find_or_create_by(name: artist_name, spotify_id: artist_id, avatar: params[:artist_pic])
        song = Song.find_or_create_by(name: song_name, artist_id: artist.id)
        @bandpost = Bandpost.create(band_id: band_id, artist_id: artist.id, song_id: song.id)
        instruments.each do |inst|
            Bandpostinstrument.create(instrument_id: inst, bandpost_id: @bandpost.id)
        end
        @bandpost.clip.attach(params[:clip])
        render json: @bandpost, serializer: BandpostSerializer
    end
end
