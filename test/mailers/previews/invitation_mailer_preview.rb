# Preview all emails at http://localhost:3000/rails/mailers/invitation_mailer
class InvitationMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/invitation_mailer/send_invitation
  def send_invitation
    InvitationMailer.send_invitation(Invitation.first, Event.first)
  end

end
