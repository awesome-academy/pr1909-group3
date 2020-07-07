class Dashboard::InvitationsController < Dashboard::ApplicationController
  before_action :load_event
  before_action :set_invitation, only: [:show, :edit, :update, :destroy]

  def index
    @tab = params["filter"] == "confirmed" ? "confirmed" : "unconfirmed"
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
      format.html { redirect_to invitations_url, notice: I18n.t("notice.invitation") }
      format.json { head :no_content }
    end
  end

  private

  def set_invitation
    @invitation = Invitation.find(params[:id])
  end

  def load_event
    @event = Event.find_by id: params[:event_id]
    return if @event
    flash[:danger] = I18n.t("notice.load_event")
    redirect_to dashboard_events_path
  end

  def invitation_params
    params.require(:invitation).permit(:name, :email, :event_id)
  end
end
