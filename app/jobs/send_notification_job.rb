class SendNotificationJob < ApplicationJob
  queue_as :default

  def perform(post, user, noti)
    # Do something later
    client = Exponent::Push::Client.new
    # byebug
    messages = [{
      to: post.user.notification_token.token,
      body: "#{user.username} commented on your post!",
      data: CommentNotificationSerializer.new(@new_notification)
    }]
    handler = client.send_messages(messages)
  end
end
