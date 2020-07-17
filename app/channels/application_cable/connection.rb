module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_participant

    def connect
      self.current_participant = find_verified_participant
    end

    private
    def find_verified_participant
      verified_participant = Participant.find_by(id: cookies.signed[:participant_id])
    end
  end
end
