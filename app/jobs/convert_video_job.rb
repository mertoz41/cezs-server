class ConvertVideoJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    VideoConverter.new(post_id).convert!
    # Do something later
  end
end
