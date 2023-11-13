class CreateNotificationJob
  include Sidekiq::Job

  def perform(data)
    # Do something
    NotificationCreator.new(data).create!

  end
end
