class ParticipantsController < ApplicationController
  before_action :set_participant, only: %i[edit update]

  def edit; end

  def update
    @participant.update(participant_params)
  end

  private

  def set_participant
    @participant = Participant.find(params[:id])
  end

  def participant_params
    params.require(:participant).permit(:name)
  end
end
