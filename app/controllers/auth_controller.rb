class AuthController < ApplicationController
    skip_before_action :authorized, only: [:create, :requestpasswordreset, :resetpassword]

    def create
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            payload = {user_id: @user.id}
            token = encode(payload)
            @chatrooms = @user.chatrooms

            render json: {
                user: UserSerializer.new(@user), 
                token: token, 
                chatrooms: ActiveModel::Serializer::CollectionSerializer.new(@chatrooms, each_serializer: ChatroomSerializer),
        
                }
        else 
            render json: {message: 'Invalid username or password.'}
        end
    end

    def check
        token = request.headers["Authorization"].split(' ')[1]
        @user = User.find(decode(token)["user_id"])
        @chatrooms = @user.chatrooms
        render json: {
            user: UserSerializer.new(@user), 
            chatrooms: ActiveModel::Serializer::CollectionSerializer.new(@chatrooms, each_serializer: ChatroomSerializer),

        }
    end

    def requestpasswordreset
        user = User.find_by(email: params[:email])
        if user
            user.generate_password_token!
            # SEND EMAIL HERE
            UserMailer.password_reset_email(user).deliver_now
            render json: { found: true, username: user.username}
        else
            render json: { found: false }
        end
    end


    def resetpassword
        token = params[:token].to_s
        user = User.find_by(reset_token: token)
        if user.present? && user.password_token_valid?
            if user.reset_password!(params[:password])
                render json: {message: 'password changed', valid: true}
            end
        else
            render json: {message: "Link not valid or expired.", valid: false}
        end
    end


end
