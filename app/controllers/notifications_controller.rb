class NotificationsController < ApplicationController
    def experiment
        client = Exponent::Push::Client.new
        messages = [{
            to: "ExponentPushToken[yNBKrFMv4sXjHe73bKjo8G]",
            body: 'experimenting'
        }]
        handler = client.send_messages(messages)
    end
end
