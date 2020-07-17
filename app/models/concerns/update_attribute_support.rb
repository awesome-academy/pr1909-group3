module UpdateAttributeSupport
  extend ActiveSupport::Concern


  def changeStatus
    update_attributes active: !active, starts_on: Time.current
  end

  def lock_answer
    update_attributes stop_answer: !stop_answer
  end

  def lock_vote
    update_attributes stop_vote: !stop_vote
  end

  included do
    before_update do
      @active_changed = false
      @active_changed = true if active_changed?
    end
  end
end
