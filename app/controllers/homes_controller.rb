class HomesController < ApplicationController
  def index
    redirect_to(current_participant.event) if logged_in_event?
  end
end
