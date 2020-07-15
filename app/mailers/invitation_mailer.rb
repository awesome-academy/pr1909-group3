class InvitationMailer < ApplicationMailer
  def send_invitation invitation, event
    @event = event
    @invitation = invitation

    mail to: @invitation.email
  end
end
