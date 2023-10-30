class CreateNotificationJob < ApplicationJob
    queue_as :default
  
    def perform(data)
      # Do something later
      NotificationCreator.new(data).create!
    end
  end
  