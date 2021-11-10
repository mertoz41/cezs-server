class SendNotificationJob < ApplicationJob
  queue_as :default

  def perform(token, body, data)
    # Do something later
    NotificationSender.new(token, body, data).send!
    # client = Exponent::Push::Client.new
    # # byebug
    # messages = [{
    #   to: post.user.notification_token.token,
    #   body: "#{user.username} commented on your post!",
    #   data: CommentNotificationSerializer.new(@new_notification)
    # }]
    # handler = client.send_messages(messages)
  end
end
