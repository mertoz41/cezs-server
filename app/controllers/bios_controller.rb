class BiosController < ApplicationController
    def create
        @user = User.find(params[:user_id])
        user_bio = Bio.create(description: params[:description], user_id: @user.id)
        render json: {user: UserSerializer.new(@user)}


    end 

    def update
        @user = User.find(params[:user_id])
        bio = @user.bio
        bio.update(description: params[:description])
        render json: {user: UserSerializer.new(@user)}
    end
end
