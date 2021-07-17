module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      self.current_user = find_verified_user
    end

    private
      def find_verified_user
        header_array = request.headers[:HTTP_SEC_WEBSOCKET_PROTOCOL].split(',')
        token = header_array[header_array.length-1].strip()      
        user_id = JWT.decode(token, 'experiment', true, {algorithm: 'HS256'})[0]
        user = User.find(user_id["user_id"])
        if user
          user
        else
          reject_unauthorized_connection
        end
      end
  end
end
