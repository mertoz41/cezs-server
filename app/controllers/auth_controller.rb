class AuthController < ApplicationController
    def create
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            payload = {user_id: @user.id}
            token = encode(payload)
            render json: {user: UserSerializer.new(@user), token: token}
        else 
            render json: {message: 'Invalid username or password.'}
        end
    end

    def check
        @user = User.find(decode(params[:token])["user_id"])
        render json: {user: UserSerializer.new(@user)}
    end

end
