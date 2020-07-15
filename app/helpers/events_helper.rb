# frozen_string_literal: true

module EventsHelper
  def intend_time(start_time, end_time)
    return 'undefine' if end_time.nil?
    ((end_time - start_time) * 24 * 60).to_i
  end

  def remember_participant(event)
    participant = Participant.create(event: event, name: 'No Name', is_admin: false)
    cookies.permanent.signed[:participant_id] = participant.id
    cookies.permanent[:authen_event_token] = participant.participant_token
    session[:participant_id] = participant.id
  end

  def forget_participant
    cookies.permanent.signed[:participant_id] = nil
    cookies.permanent[:authen_event_token] = nil
    session[:participant_id] = nil
  end

  def current_participant
    if (participant_id = session[:participant_id])
      @current_participant ||= Participant.find_by(id: participant_id)
    elsif (participant_id = cookies.signed[:participant_id])
      participant = Participant.find_by(id: participant_id)
      if participant&.event_authenticated?(cookies[:authen_event_token])
        log_in_event participant
        @current_participant = participant
      end
    end
  end

  def log_in_event(participant)
    session[:participant_id] = participant.id
  end

  def logged_in_event?
    !current_participant.nil?
  end

  def active_button(object)
    if object.active
      '<span class="btn btn-success"><i class="fa fa-sign-out"></i></span>'.html_safe
    else
      '<span class="btn btn-danger"><i class="fa fa-sign-in"></i></span>'.html_safe
    end
  end

  def lock_answer_button(object)
    if object.stop_answer
      '<i class="fa fa-lock"></i>'.html_safe
    else
      '<i class="fa fa-unlock"></i>'.html_safe
    end
  end

  def lock_vote_button(object)
    if object.stop_vote
      '<i class="fa fa-lock"></i>'.html_safe
    else
      '<i class="fa fa-unlock"></i>'.html_safe
    end
  end

  def time_shower(time, options = {})
    options[:class] ||= 'timeago'
    if time
      content_tag(
        :time,
        time.to_s,
        options.merge(datetime: time.getutc.iso8601)
      )
    end
  end
end
