class SendNotificationJob
  include Sidekiq::Job

  def perform(token, body, data)
    # Do something
    NotificationSender.new(token, body, data).send!

  end
end
