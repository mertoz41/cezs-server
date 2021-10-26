class TimelineController < ApplicationController
    def user_timeline
        user = User.find(params[:user_id])
        post = Post.find(params[:last_post])
        @timeline = user.timeline_refresh(post.created_at)
        # if params[:post_id]
        #     new_posts = Post.where('created_at > ?', Post.find(params[:post_id]).created_at)
        #     @timeline + new_posts
        # end
        render json: {timeline: ActiveModel::Serializer::CollectionSerializer.new(@timeline, each_serializer: PostSerializer)}
    end
end
