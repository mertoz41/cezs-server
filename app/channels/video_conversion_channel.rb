class VideoConversionChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "video_conversion_channel_#{params[:user_id]}"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
