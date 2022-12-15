class ApplicationController < ActionController::API
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

    def blokes
      blocked_ids = logged_in_user.blocked_users.map {|user| user.id}
      blocking_ids = logged_in_user.blocking_users.map {|user| user.id}
      blokes = blocked_ids.concat(blocking_ids)
      return blokes
    end

    def band_blokes
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
        render json: { message: 'Please log in' }, status: :unauthorized unless logged_in?
    end
end
