class CreateNotificationJob
  include Sidekiq::Job

  def perform(data)
    NotificationCreator.new(data).create!
  end
end
