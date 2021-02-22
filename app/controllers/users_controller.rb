class UsersController < ApplicationController

    def create
        user = User.create(username: params[:username], password: params[:password])
        render json: {message: "Success!"}
    end

    # def experiment
    #     byebug
    # end 
end
