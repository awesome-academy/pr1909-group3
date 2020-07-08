class EventsController < ApplicationController
  before_action :set_event, except: %i(index join_by_code checkout_event)
  before_action :correct_user, only: [:show]

  def index
    @events = Event.all
  end

  def show
    gon.event = @event
    @notes = @event.notes.actived
    @timeline = @event.timeline
  end

  def join_by_code
    if @event = Event.find_by_degit_code(params[:degit_code])
      redirect_ajax event_path(@event)
      remember_participant @event
    else
      # redirect ve trang dang nhap va hien thong bao
    end
  end

  def checkout_event
    forget_participant
    redirect_to root_path
  end

  def questions
    @questions = @event.questions.actived
  end

  def notes
    @notes = @event.notes.actived
  end

  def my_questions
    @questions = @event.questions.where(participant: current_participant)
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def correct_user
    if current_participant.nil?
      redirect_to root_path
    else
      redirect_to root_path unless current_participant.event_id == @event.id
    end
  end
end
