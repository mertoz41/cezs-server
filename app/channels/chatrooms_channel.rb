class ChatroomsChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "chatrooms_channel"
    # byebug
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end