class GenresController < ApplicationController
    def index
        @genres = Genre.all
        render json: {genres: ActiveModel::Serializer::CollectionSerializer.new(@genres, each_serializer: GenreSerializer)}
    end 

    def genresearch
        genres = Genre.where("name like?", "%#{params[:searching]}%")
        render json: {genres: genres.as_json(:except => [:created_at, :updated_at])}
    end

    def createusergenre
        @user = User.find(params[:user_id])
        genre = Genre.find_or_create_by(name: params[:genre])
        user_genre = Usergenre.create(user_id: @user.id, genre_id: genre.id)
        render json: {genre: {id: genre.id, name: genre.name}}
    end

    def deleteusergenre
        @user = User.find(params[:user_id])
        user_genre = Usergenre.find_by(user_id: @user.id, genre_id: params[:genre_id])
        user_genre.destroy
        render json: {message: 'genre deleted.'}
    end

    def createbandgenre
        @band = Band.find(params[:band_id])
        genre = Genre.find_or_create_by(name: params[:genre])
        band_genre = Bandgenre.create(band_id: @band.id, genre_id: genre.id)
        render json: {genre: {id: genre.id, name: genre.name}}
    end

    def deletebandgenre
        @band = Band.find(params[:band_id])
        band_genre = Bandgenre.find_by(band_id: @band.id, genre_id: params[:genre_id])
        band_genre.destroy
        render json: {message: 'genre deleted.'}
    end
end
