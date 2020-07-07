class QuestionChannel < ApplicationCable::Channel
  def subscribed
    stream_from "question_#{params[:id]}_channel"
  end
end
