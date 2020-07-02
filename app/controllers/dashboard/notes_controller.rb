class Dashboard::NotesController < Dashboard::DashboardController
  before_action :load_event
  before_action :load_note, except: %i(new index create)
  def index
    @notes = @event.notes.order(created_at: :desc)
  end

  def show; end

  def new
    @note = Note.new
    gon.push(event: @event)
  end

  def edit; end

  def create
    @note = @event.notes.build note_params
    @note.message_to_stream('create', 'admin') if @note.save
  end

  def update
    if @note.update_attributes note_params
      @note.message_to_stream('update_content', 'all')
    else
      respond_to do |format|
        format.js
      end
    end
  end

  def destroy
    @note.message_to_stream('delete', 'all') if @note.destroy
  end

  def change_status
    return unless @note.changeStatus
    action = @note.active ? 'enable_time_line' : 'disable_time_line'
    @note.message_to_stream(action, 'all')
  end

  private

  def load_note
    @note = Note.find_by id: params[:id]
    return if @note
    flash[:danger] = t '.danger'
    redirect_to admin_events_path
  end

  def load_event
    @event = Event.find_by id: params[:event_id]
    return if @event
    flash[:danger] = t '.danger'
    redirect_to dashboard_events_path
  end

  def note_params
    params.require(:note).permit :content, :starts_on,
                                 :event_id, :active, :title
  end
end
