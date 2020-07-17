class InvitationConfirmationsController < ApplicationController
  def edit
    invitation = Invitation.find_by(event_id: params[:event_id], email: params[:email])
    if invitation && invitation.authenticated?(:invitation, params[:id])
      invitation.update_attribute(:confirm, true)
      set_participant invitation
      flash[:success] = "Account activated!"
      redirect_to root_url
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end

  private

  def set_participant invitation
    if invitation.participant_id
      participant = Participant.create(event: event, name: invitation.name, role: 1)
    else
      participant = Participant.find_by(id: invitation.id)
    end
    cookies.permanent.signed[:participant_id] = participant.id
    cookies.permanent[:authen_event_token] = participant.participant_token
    session[:participant_id] = participant.id
  end
end
