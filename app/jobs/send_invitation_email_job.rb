class SendInvitationEmailJob < ApplicationJob
  queue_as :default

  def perform(name, email, event)
    @invitation = Invitation.new(
      name: name,
      email: email,
      event_id: event.id
    )

    if @invitation.save
      InvitationMailer.send_invitation(@invitation, event).deliver_now
    end

  end
end
