class Dashboard::ParticipantsController < Dashboard::DashboardController
  before_action :set_participant, only: [:show, :edit, :update, :destroy]
  before_action :load_event, only: [:index, :admin_list, :set_admin]

  def index
    @participants = @event.participants
  end

  def show
  end

  def new
    @participant = current_user.participants.build
  end

  def edit
  end

  def create
    @participant = Participant.new(participant_params)
    redirect_ajax dashboard_participants_path if @participant.save
  end

  def update
    if @participant.update(participant_params)
    else
      format.html { render :edit }
      format.json { render json: @participant.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @participant.destroy
    respond_to do |format|
      format.html { redirect_to participants_url, notice: 'Participant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def import; end

  def admin_list
    @participants = @event.participants
  end

  def set_admin
    Participant.update_admin(@event, params[:contact_ids])
  end

  private

  def set_participant
    @participant = Participant.find(params[:id])
  end

  def participant_params
    params.require(:participant).permit(:name, :id)
  end

  def load_event
    @event = Event.find_by id: params[:event_id]
    return if @event
    flash[:danger] = I18n.t("danger.text")
    redirect_to dashboard_events_path
  end
end
