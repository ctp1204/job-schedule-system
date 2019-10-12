class SuggestsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "suggest_channel_#{current_user.id}"
  end
end
