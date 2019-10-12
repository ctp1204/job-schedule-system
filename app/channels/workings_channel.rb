class WorkingsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "working_channel"
  end
end
