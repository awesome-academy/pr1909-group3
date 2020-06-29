module UpdateAttributeSupport
  extend ActiveSupport::Concern

  def changeStatus
    update_attributes active: !active, starts_on: Time.current
  end

  included do
    before_update do
      @active_changed = false
      @active_changed = true if active_changed?
    end
  end
end
