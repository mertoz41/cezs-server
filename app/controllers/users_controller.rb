class UsersController < ApplicationController

    def create
        user = User.create(username: params[:username], password: params[:password])
        render json: {message: "Success!"}
    end

    def avatar
        @user = User.find(params[:user_id])
        @user.avatar.attach(params[:avatar])
        render json: @user, serializer: UserSerializer
    end

    # def experiment
    #     byebug
    # end 
end
