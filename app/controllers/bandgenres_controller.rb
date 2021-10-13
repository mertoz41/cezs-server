class BandgenresController < ApplicationController
    def create
        @band = Band.find(params[:band_id])
        genre = Genre.find_or_create_by(name: params[:genre])
        user_genre = Bandgenre.create(band_id: @band.id, genre_id: genre.id)
        render json: {genre: {id: genre.id, name: genre.name}}
    end

    def delete
        @band = Band.find(params[:band_id])
        band_genre = Bandgenre.find_by(band_id: @band.id, genre_id: params[:genre_id])
        band_genre.destroy
        render json: {message: 'genre deleted.'}
    end
end
