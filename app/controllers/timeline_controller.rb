class TimelineController < ApplicationController
    def user_timeline
        post = Post.find(params[:last_post])
        new_follow_posts = params[:newPostIds].map {|id| Post.find(id)}
        new_posts = logged_in_user.timeline_refresh(post.created_at)
        mixed_timeline = new_follow_posts + new_posts
        byebug
        @timeline = mixed_timeline.sort_by(&:created_at).reverse.uniq
        
        # if params[:post_id]
        #     new_posts = Post.where('created_at > ?', Post.find(params[:post_id]).created_at)
        #     @timeline + new_posts
        # end
        render json: {timeline: ActiveModel::Serializer::CollectionSerializer.new(@timeline, each_serializer: PostSerializer)}
    end
end
