class QuestionUpdateJob < ApplicationJob
  queue_as :default

  def perform(data)
    puts "question_#{data[:question_id]}_channel"
    ActionCable.server.broadcast "question_#{data[:question_id]}_channel",
                                 data
  end
end
