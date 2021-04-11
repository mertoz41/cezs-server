class AuthController < ApplicationController
    def create
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            payload = {user_id: @user.id}
            token = encode(payload)
            @timeline = []
            @posts = []
            @shares = @user.shares

            @user.posts.each do |post|
                @posts.push(post)
                @timeline.push(post)
            end 
            @user.followeds.each do |user|
                user.posts.each do |post|
                @timeline.push(post)
                end 
            end 

            render json: {user: UserSerializer.new(@user), token: token, shares: ActiveModel::Serializer::CollectionSerializer.new(@shares, each_serializer: ShareSerializer),timeline: ActiveModel::Serializer::CollectionSerializer.new(@timeline, each_serializer: PostSerializer), posts: ActiveModel::Serializer::CollectionSerializer.new(@posts, each_serializer: PostSerializer)}
        else 
            render json: {message: 'Invalid username or password.'}
        end
    end

    def check
        @user = User.find(decode(params[:token])["user_id"])
        @timeline = []
        @posts = []
            
        chatrooms = []
        @user.chatrooms.each do |room|
            obj = {}
            obj = room.attributes
            @room_users = room.users
            obj['users'] = ActiveModel::Serializer::CollectionSerializer.new(@room_users, each_serializer: UserSerializer)
            chatrooms.push(obj)
        end 
        @user.followedbands.each do |band|
            band.bandposts.each do |bandpost|
                @timeline.push(bandpost)
            end
        end 
        @shares = @user.shares
            @user.posts.each do |post|
                @posts.push(post)
                @timeline.push(post)
            end 
            @user.followeds.each do |user|
                user.posts.each do |post|
                @timeline.push(post)
                end 
            end 
        
        render json: {user: UserSerializer.new(@user), shares: ActiveModel::Serializer::CollectionSerializer.new(@shares, each_serializer: ShareSerializer) ,timeline: ActiveModel::Serializer::CollectionSerializer.new(@timeline, each_serializer: PostSerializer), posts: ActiveModel::Serializer::CollectionSerializer.new(@posts, each_serializer: PostSerializer), chatrooms: chatrooms}
    end

end
