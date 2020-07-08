class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :load_event, only: %i(new)

  def index; end

  def new
    @question = current_participant.questions.build
  end

  def edit
    @event = @question.event
  end

  def create
    @question = current_participant.event.questions.build(question_params)
    @action_status = @question.save
    @question.message_to_stream('create', 'admin') if @action_status
  end

  def update
    if @question.update(question_params)
      @question.message_to_stream('update_content', 'admin')
    end
  end

  def destroy
    if @question.destroy
      @question.message_to_stream('delete', 'all')
    end
  end

  def show
    @answer = Answer.new
    gon.question = @question
    @answers = @question.answers.includes(:participant)
  end

  private

  def set_question
    @question = Question.includes(:answers).find(params[:id])
  end

  def load_event
    @event = Event.find_by id: params[:event_id]
    return if @event
    flash[:danger] = t ".danger"
    redirect_to dashboard_events_path
  end

  def question_params
    params.require(:question).permit(:content, :starts_on, :title, :event_id, :participant_id)
  end
end
