module EventsHelper
  def current_participant
    if (participant_id = session[:participant_id])
      @current_participant ||= Participant.find_by(id: participant_id)
    elsif (participant_id = cookies.signed[:participant_id])
      participant = Participant.find_by(id: participant_id)
      if participant && participant.event_authenticated?(cookies[:authen_event_token])
        log_in_event participant
        @current_participant = participant
      end
    end
  end

  def active_button(object)
    if object.active
      '<span class="btn btn-success"><i class="fa fa-sign-out"></i></span>'.html_safe
    else
      '<span class="btn btn-danger"><i class="fa fa-sign-in"></i></span>'.html_safe
    end
  end

  def log_in_event(participant)
    session[:participant_id] = participant.id
  end

  def logged_in_event?
    !current_participant.nil?
  end
end
