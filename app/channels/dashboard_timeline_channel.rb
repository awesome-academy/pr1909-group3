class DashboardTimelineChannel < ApplicationCable::Channel
  def subscribed
    stream_from "dashboard_event_#{params[:id]}_timeline_channel"
  end
end
