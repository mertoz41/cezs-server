class GenresController < ApplicationController
    def index
        genres = Genre.all
        render json: {genres: genres}
    end 

    def genresearch
        genres = Genre.where("name like?", "%#{params[:searching]}%")
        render json: {genres: genres}
    end
end
