class TimelineController < ApplicationController
    def user_timeline
        user = User.find(params[:user_id])
        @timeline = []
        if params[:post_id]
            new_posts = Post.where('created_at > ?', Post.find(params[:post_id]).created_at)
            @timeline + new_posts
        end

        if params[:bandpost_id]
            new_bandposts = Bandpost.where('created_at > ?', Bandpost.find(params[:bandpost_id]).created_at)
            @timeline + new_bandposts
        end

        if params[:userdescpost_id]
            new_userdescposts = Userdescpost.where('created_at > ?', Userdescpost.find(params[:userdescpost_id]).created_at)
            @timeline + new_userdescposts
        end

        if params[:banddescpost_id]
            new_banddescposts = Banddescpost.where('created_at > ?', Banddescpost.find(params[:banddescpost_id]).created_at)
            @timeline + new_banddescposts
        end
        render json: {timeline: ActiveModel::Serializer::CollectionSerializer.new(@timeline, each_serializer: PostSerializer)}
    end
end
