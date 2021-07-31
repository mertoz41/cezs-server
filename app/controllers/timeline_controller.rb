class TimelineController < ApplicationController
    def user_timeline
        user = User.find(params[:id])
        @timeline = []
        user.posts.each do |post|
            # @posts.push(post)
            @timeline.push(post)
        end 
        user.bands.each do |band|
            band.bandposts.each do |bandpost|
                @timeline.push(bandpost)
            end
        end
        user.followeds.each do |user|
            user.posts.each do |post|
            @timeline.push(post)
            end 
        end
        user.followedbands.each do |band|
            band.bandposts.each do |bandpost|
                @timeline.push(bandpost)
            end
        end 
        user.followedartists.each do |artist|
            artist.posts.each do |post|
                @timeline.push(post)
            end
            artist.bandposts.each do |post|
                @timeline.push(post)
            end
        end 
        user.userdescposts.each do |post|
            @timeline.push(post)
        end
        render json: {timeline: ActiveModel::Serializer::CollectionSerializer.new(@timeline, each_serializer: PostSerializer)}
    end
end
