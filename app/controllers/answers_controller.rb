class AnswersController < ApplicationController
  before_action :set_answer, only: %i[show edit update destroy]

  def index
    @answers = Answer.all
  end

  def create
    @answer = current_participant.answers.build(answer_params)
    if @answer.save
      @answer.answer_to_stream('create', 'participant', current_participant.id)
    end
  end

  private

  def set_answer
    @answer = Answer.find(params[:id])
  end

  def answer_params
    params.require(:answer).permit(:content, :question_id, :participant_id)
  end
end
