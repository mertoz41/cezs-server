class ApplicationController < ActionController::API
    def encode(payload)
        JWT.encode(payload, 'experiment', 'HS256')
    end

    def decode(token)
        JWT.decode(token, 'experiment', true, {algorithm: "HS256"})[0]
    end 
end
