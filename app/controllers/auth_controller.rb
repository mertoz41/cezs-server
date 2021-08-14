class AuthController < ApplicationController
    skip_before_action :authorized, only: [:create]

    def create
        @user = User.find_by(username: params[:username])
        if @user && @user.authenticate(params[:password])
            payload = {user_id: @user.id}
            token = encode(payload)
            @timeline = []
            chatrooms = []
            @user.chatrooms.each do |room|
                obj = {}
                obj = room.attributes
                @room_users = room.users
                obj['users'] = ActiveModel::Serializer::CollectionSerializer.new(@room_users, each_serializer: UserSerializer)
                chatrooms.push(obj)
            end 

            @user.posts.each do |post|
                @timeline.push(post)
            end 
            @user.bands.each do |band|
                band.posts.each do |bandpost|
                    @timeline.push(bandpost)
                end
            end
            @user.followeds.each do |user|
                user.posts.each do |post|
                @timeline.push(post)
                end 
            end
            @user.followedbands.each do |band|
                band.posts.each do |bandpost|
                    @timeline.push(bandpost)
                end
            end 
            @user.followedartists.each do |artist|
                artist.posts.each do |post|
                    @timeline.push(post)
                end

            end 
            @user.followedsongs.each do |song|
                song.posts.each do |post|
                    @timeline.push(post)
                end
            end


            render json: {user: UserSerializer.new(@user), token: token, timeline: ActiveModel::Serializer::CollectionSerializer.new(@timeline, each_serializer: PostSerializer), chatrooms: chatrooms}
        else 
            render json: {message: 'Invalid username or password.'}
        end
    end

    def check
        token = request.headers["Authorization"].split(' ')[1]
        @user = User.find(decode(token)["user_id"])
        @timeline = []
            
        chatrooms = []
        @user.chatrooms.each do |room|
            obj = {}
            obj = room.attributes
            @room_users = room.users
            obj['users'] = ActiveModel::Serializer::CollectionSerializer.new(@room_users, each_serializer: UserSerializer)
            chatrooms.push(obj)
        end 
        @user.followedbands.each do |band|
            band.posts.each do |bandpost|
                @timeline.push(bandpost)
            end
        end 
        @user.bands.each do |band|
            band.posts.each do |bandpost|
                @timeline.push(bandpost)
            end
        end
        
        @user.followedartists.each do |artist|
            artist.posts.each do |post|
                @timeline.push(post)
            end
        end 
        
            @user.posts.each do |post|
                @timeline.push(post)
            end
           
            @user.followeds.each do |user|
                user.posts.each do |post|
                @timeline.push(post)
                end
            end 
        
        render json: {user: UserSerializer.new(@user), timeline: ActiveModel::Serializer::CollectionSerializer.new(@timeline, each_serializer: PostSerializer)}
    end

end
