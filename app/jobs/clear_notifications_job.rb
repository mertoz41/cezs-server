class ClearNotificationsJob < ApplicationJob
  queue_as :default

  def perform(*args)
    # Do something later
    # notifications that are seen and created for 10 days will be deleted here
  end
end
