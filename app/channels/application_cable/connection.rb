module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_user

    def connect
      # self.current_user = find_verified_user
    end

    private
      def find_verified_user
        # or however you want to verify the user on your system
        user_id = JWT.decode(request[:token], 'experiment', true, {algorithm: 'HS256'})[0]["user_id"]
        
        # client_id = request.params[:client]
        # verified_user = User.find_by(email: client_id)
        if user = User.find(user_id)
          user
        else
          reject_unauthorized_connection
        end
      end
  end
end
