class ConvertVideoJob
  include Sidekiq::Job

  def perform(post_id, user_id)
    VideoConverter.new(post_id, user_id).convert!
  end
end
