class TimelineController < ApplicationController
    def user_timeline
        post = Post.find(params[:last_post])
        new_follow_posts = []
        
        if params[:newPostIds]
            posts = params[:newPostIds].map {|id| Post.find(id)}
            new_follow_posts = new_follow_posts + posts
        end
        
        new_posts = logged_in_user.timeline_refresh(post.created_at)
        mixed_timeline = new_follow_posts + new_posts
        @timeline = mixed_timeline.uniq
        render json: {timeline: ActiveModel::Serializer::CollectionSerializer.new(@timeline, each_serializer: PostSerializer)}
    end

    def older_posts
        posts = logged_in_user.get_older_posts(params[:last_created_at])
        if posts.size === 0
            render json: {message: "No post left to display"}
        else
            render json: {older_posts: ActiveModel::Serializer::CollectionSerializer.new(posts, each_serializer: PostSerializer, scope: logged_in_user)}
        end
    end
end
