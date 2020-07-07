class PollUpdateJob < ApplicationJob
  queue_as :default

  def perform(data)
    puts "poll_#{data[:poll].id}_channel"
    ActionCable.server.broadcast "poll_#{data[:poll].id}_channel",
                                 data
  end
end
