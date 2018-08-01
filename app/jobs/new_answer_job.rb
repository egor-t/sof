class NewAnswerJob < ApplicationJob
  queue_as :default

  def perform(answer)
    QuestionsMailer.new_answer(answer).deliver_now
  end
end
