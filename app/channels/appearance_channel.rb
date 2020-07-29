class AppearanceChannel < ApplicationCable::Channel
  def subscribed
    stream_from "appearance"
  end

  def unsubscribed
    $redis.hdel "event-#{params[:id]}", current_participant.id
    ActionCable.server.broadcast "appearance",
      active_participants: ($redis.hgetall "event-#{current_participant.event_id}")
  end

  def appear
    hash = { current_participant.id => current_participant.name }
    $redis.mapped_hmset "event-#{params[:id]}", hash
    ActionCable.server.broadcast "appearance",
      active_participants: ($redis.hgetall "event-#{current_participant.event_id}")
  end
end
