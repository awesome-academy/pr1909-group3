class Dashboard::InvitationsController < Dashboard::DashboardController
  before_action :load_event
  before_action :set_invitation, only: [:show, :edit, :update, :destroy]

  def index
    @tab = params["filter"] == "confirmed" ? "confirmed" : "unconfirmed"
    @invitations = @event.invitations.send(@tab)
  end

  def show; end

  def new
    @invitation = current_user.invitations.build
  end

  def edit; end

  def create
    @invitation = Invitation.new(invitation_params)
    redirect_ajax dashboard_invitations_path if @invitation.save
  end

  def update
    if @invitation.update(invitation_params)
    else
      format.html { render :edit }
      format.json { render json: @invitation.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @invitation.destroy
    respond_to do |format|
      format.html { redirect_to invitations_url, notice: 'Invitation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import
    if !params[:file].present?
      flash[:danger] = t(".not_found")
    else
      Invitation.import params[:file], params[:event_id]
      flash[:success] = t(".success")
    end
    redirect_to dashboard_event_invitations_path
  end

  def list_invited
    contacts = current_user.contacts.order(:name).pluck(:name, :email, :id)
    invited_contacts = @event.invitations.pluck(:email)
    @list_contact = contacts.select { |contact| invited_contacts.exclude? contact[0] }
  end

  def invite_by_contact
    contact_ids = params[:contact_ids]
    contacts = Contact.select(:name, :email).where(id: contact_ids)
    contacts.each do |contact|
      SendInvitationEmailJob.perform_later(contact.name, contact.email, @event)
    end
  end

  private

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end

  def load_event
    @event = Event.find_by id: params[:event_id]
    return if @event
    flash[:danger] = t ".danger"
    redirect_to dashboard_events_path
  end

  def invitation_params
    params.require(:invitation).permit(:name, :email, :event_id)
  end
end
