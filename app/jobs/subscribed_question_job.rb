# frozen_string_literal: true

class SubscribedQuestionJob < ApplicationJob
  queue_as :default

  def perform(answer)
    answer.question.subscribers.each do |user|
      QuestionMailer.notify_about_new_answer(answer, user).deliver_later
    end
  end
end
