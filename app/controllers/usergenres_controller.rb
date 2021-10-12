class UsergenresController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        genre = Genre.find_or_create_by(name: params[:genre])
        user_genre = Usergenre.create(user_id: @user.id, genre_id: genre.id)
        render json: {genre: {id: genre.id, name: genre.name}}
    end

    def delete
        @user = User.find(params[:user_id])
        user_genre = Usergenre.find_by(@user.id, genre_id: params[:genre_id])
        user_genre.destroy
        render json: {message: 'genre deleted.'}
    end
end
