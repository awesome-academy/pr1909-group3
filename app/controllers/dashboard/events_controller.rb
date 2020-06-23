class Dashboard::EventsController < ApplicationController
  before_action :set_event, only: %i(show edit update destroy)

  def index
    @events = current_user.events
  end

  def show
    gon.event = @event
    @timeline = @event
  end

  def new
    byebug
    @event = current_user.events.build
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def create
    @event = current_user.events.build(event_params)
    redirect_ajax dashboard_root_path if @event.save
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :starts_on, :ends_on, :description, :degit_code, :user_id)
  end
end
