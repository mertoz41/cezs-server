class ConvertVideoJob < ApplicationJob
  queue_as :default

  def perform(post_id, user_id)
    VideoConverter.new(post_id, user_id).convert!
    # Do something later
  end
end
