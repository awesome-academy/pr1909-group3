class TimelineChannel < ApplicationCable::Channel
  def subscribed
    stream_from "event_#{params[:id]}_timeline_channel"
  end
end
