class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :participant

  validates :content, presence: true

  def answers_to_stream(action_type, display, current_participant_id)
    data = {
      action: action_type,
      participant_id: participant_id,
      answer_html: answer_html_render(display, current_participant_id),
      other_answer_html: answer_html_render(display, nil),
      question_id: question_id,
      id: id,
    }
    QuestionUpdateJob.perform_later(data)
  end

  private

  def answer_html_render(display, current_participant_id)
    ApplicationController.render(
      partial: "#{display == 'admin' ? 'dashboard/' : ''}answers/answer",
      locals: { answer: self, current_participant_id: current_participant_id }
    )
  end
end
