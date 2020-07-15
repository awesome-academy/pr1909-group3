class Dashboard::PollsController < Dashboard::DashboardController
  layout "empty", :only => [ :show ]
  before_action :load_event
  before_action :load_poll, except: [:new, :index, :create]
  def index
    @polls = @event.polls.order(created_at: :desc)
  end

  def show
    gon.poll = @poll
    gon.result = @poll.options.select(:id, :content, :votes_count)
  end

  def new
    @poll = Poll.new
    gon.push({ event: @event } )
  end

  def edit; end

  def create
    @poll = @event.polls.build poll_params
    if @poll.save
      @poll.message_to_stream('create', 'admin')
    else
    end
  end

  def update
    if @poll.update_attributes poll_params
      @poll.message_to_stream('update_content', 'all')
    end
  end

  def destroy
    if @poll.destroy
      @poll.message_to_stream('delete', 'all')
    end
  end

  def change_status
    return unless @poll.changeStatus
    action = @poll.active ? 'enable_time_line' : 'disable_time_line'
    @poll.message_to_stream(action, 'all')
  end

  def lock_vote
    return unless @poll.lock_vote
    @poll.message_to_stream('update_content', 'all')
  end

  private

  def load_poll
    @poll = Poll.find_by id: params[:id]
    return if @poll
    flash[:danger] = t ".danger"
    redirect_to admin_events_path
  end

  def load_event
    @event = Event.find_by id: params[:event_id]
    return if @event
    flash[:danger] = t ".danger"
    redirect_to dashboard_events_path
  end

  def poll_params
    params.require(:poll).permit :content, :starts_on, :intend, :event_id, :title, :multi_vote,
                                 options_attributes:[:id, :content, :_destroy]
  end
end
