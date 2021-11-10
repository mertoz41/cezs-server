class NotificationSender
    def initialize(token, body, data)
        @token = token,
        @body = body,
        @data = data
    end

    def send!
        send_notification

    end
    private
    def send_notification
        client = Exponent::Push::Client.new
        messages = [{
            to: @token[0],
            body: @body,
            data: @data
        }]
        handler = client.send_messages(messages)

    end
end