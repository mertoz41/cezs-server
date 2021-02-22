class GenresController < ApplicationController
    def index
        genres = Genre.all
        render json: {genres: genres}
    end 
end
