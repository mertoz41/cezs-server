class ApplicationController < ActionController::Base
  include ActionView::Layouts

  before_action :authorized
    def encode(payload)
        JWT.encode(payload, 'experiment', 'HS256')
    end

    def decode(token)
        JWT.decode(token, 'experiment', true, {algorithm: "HS256"})[0]
    end

    def auth_header
        # { Authorization: 'Bearer <token>' }
        request.headers['Authorization']
    end


    def decoded_token
        if auth_header
          token = auth_header.split(' ')[1]
          # header: { 'Authorization': 'Bearer <token>' }
          begin
            JWT.decode(token, 'experiment', true, algorithm: 'HS256')
          rescue JWT::DecodeError
            nil
          end
        end
    end

    # take whatever needs to be filtered by blocks
    # posts

    def filter_blocked_users(list)
      filtered = list.select {|item| !blocked_user_list.include?(item.id)}.select {|item| !logged_in_user_blocked_by.include?(item.id)}
      return filtered
    end

    def filter_blocked_bands(list)
      filtered = list.select {|item| !blocked_band_list.include?(item.id)}
      return filtered
    end

    def filter_blocked_posts(list)
      filtered = list.select {|post| !blocked_user_list.include?(post.user_id)}.select{|post| !blocked_band_list.include?(post.band_id)}.select{|post| !logged_in_user_blocked_by.include?(post.user_id)}
      return filtered
    end

    def blocked_user_list
      blocked_user_ids = logged_in_user.blocked_users.map {|user| user.id}
      return blocked_user_ids
    end

    def logged_in_user_blocked_by
      blocker_ids = logged_in_user.blocking_users.map {|user| user.id}
      return blocker_ids
    end

    def blocked_band_list 
      blocked_ids = logged_in_user.blocked_bands.map {|band| band.id}
      return blocked_ids
    end



    def logged_in_user
        if decoded_token
          user_id = decoded_token[0]['user_id']
          @user = User.find_by(id: user_id)
        end
    end

    def logged_in?
        !!logged_in_user
    end

    def authorized
      if !params[:controller].include?  "admin/"
        render json: { message: 'Please log in', authorized: false }, status: :unauthorized unless logged_in?
      end
    end
end
