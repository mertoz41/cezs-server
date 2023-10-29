class GenresController < ApplicationController
    def index
        @genres = Genre.all
        render json: {genres: ActiveModel::Serializer::CollectionSerializer.new(@genres, each_serializer: GenreSerializer)}
    end 

    def search
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
end
