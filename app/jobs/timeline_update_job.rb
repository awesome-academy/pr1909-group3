class TimelineUpdateJob < ApplicationJob
  queue_as :default

  def perform(data)
    puts data
    ActionCable.server.broadcast "event_#{data[:event_id]}_timeline_channel",
                                 data
  end
end
