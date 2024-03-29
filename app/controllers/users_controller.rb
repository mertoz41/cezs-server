class UsersController < ApplicationController
    skip_before_action :authorized, only: [:create]
    include Rails.application.routes.url_helpers

    def create
        existing_user = User.find_by(username: params[:username])
        existing_email = User.find_by(email: params[:email])
        if existing_user
            render json: {message: "#{params[:username]} is taken.", valid: false}
        elsif existing_email
            render json: {message: "#{params[:email]} is taken.", valid: false}
        else
            user = User.new(username: params[:username], password: params[:password], email: params[:email])
            if user.valid?
                user.save
                UserMailer.welcome_email(user).deliver_now
                render json: {message: "Success!", valid: true}
            else
                render json: {message: user.errors.full_messages[0], valid: false}
            end
        end
    end

    def show
        user = User.find(params[:id])
        follows = logged_in_user.follows.find_by(followed_id: user.id) ? true : false
        render json: {user: UserViewSerializer.new(user), follows: follows }
    end 

    def passwordcheck
        if logged_in_user.authenticate(params[:password])
            render json: {confirmed: true}
        else
            render json: {confirmed: false}
        end
    end

    def changepassword
        user = logged_in_user
        if user.authenticate(params[:old])
            user.update(password: params[:newPassword]) 
            if user.valid?
                render json: {message: 'Password changed.', valid: true}
            else
                render json: {errors: user.errors.full_messages, valid: false}
            end
        else
            render json: {message: "Wrong password.", valid: false}

        end
    end

    def update
        @user = User.find(params[:id])
        @user.update(params)
            
        render json: {user: UserSerializer.new(@user)}
    end

    def avatar
        user = User.find(logged_in_user.id)
        user.avatar.attach(params[:avatar])
        render json: {message: 'picture changed.', avatar: "#{ENV['CLOUDFRONT_API']}/#{user.avatar.key}"}
    end

    def searching
        searched_users = User.where("username like?", "%#{params[:searching]}%")
        users = []
        if logged_in_user.blocked_users.size
            users = filter_blocked_users(searched_users)
        else
            users = searched_users
        end
        filtered_users = users.select {|user| user.reports.size < 1}
        # partial string matching on a database object. not a very good solution
        render json: filtered_users, each_serializer: ShortUserSerializer
        # serializer isnt very smart for this situation
    end
    def usertoken
        user = User.find(params[:user_id])
        if !user.notification_token
            new_expo_token = NotificationToken.create(user_id: user.id, token: params[:expo_token])
        else
            token = user.notification_token
            token.update(token: params[:expo_token])
        end
        render json: {message: 'token added.'}
    end
    def filter_search
        instrument_users = User.joins(:instruments).merge(Instrument.where(id: params[:instruments]))
        genre_users = User.joins(:genres).merge(Genre.where(id: params[:genres]))
        all_users = instrument_users + genre_users
        users = []
        if logged_in_user.blocked_users.size
            users = filter_blocked_users(all_users)
        else
            users = all_users
        end
        filtered_users = users.select {|user| user.reports.size < 1}
        render json: filtered_users.uniq, each_serializer: ShortUserSerializer
    end
    

    def destroy
        user = User.find(params[:id])
        user.chatrooms.destroy_all
        user.destroy
        render json: {deleted: true}
    end

end
