class SendNotificationJob < ApplicationJob
  queue_as :default

  def perform(token, body, data)
    # Do something later
    NotificationSender.new(token, body, data).send!
  end
end
