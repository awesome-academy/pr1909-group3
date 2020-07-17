class Dashboard::QuestionsController < Dashboard::DashboardController
  before_action :set_question, except: %i[new index create]
  before_action :load_event

  def index
    @questions = @event.questions.order(created_at: :desc)
  end

  def show
    @answer = Answer.new
    gon.question = @question
    @answers = @question.answers.includes(:participant)
  end

  def new
    @question = Question.new
  end

  def edit; end

  def create
    @question = @event.questions.new(question_params)
    @question.message_to_stream('create', 'admin') if @question.save
  end

  def update
    if @question.update(question_params)
      @question.message_to_stream('update_content', 'all')
    end
  end

  def destroy
    @question.message_to_stream('delete', 'all') if @question.destroy
  end

  def change_status
    return unless @question.changeStatus
    action = @question.active ? 'enable_time_line' : 'disable_time_line'
    @question.message_to_stream(action, 'all')
    end

  def lock_answer
    return unless @question.lock_answer
    @question.message_to_stream('update_content', 'all')
  end

  private

  def set_question
    @question = Question.find(params[:id])
  end

  def load_event
    @event = Event.find_by id: params[:event_id]
    return if @event
    flash[:danger] = t '.danger'
    redirect_to dashboard_events_path
  end

  def question_params
    params.require(:question).permit(:name, :starts_on, :intend, :content, :title, :event_id)
  end
end
