# frozen_string_literal: true

class QuestionMailer < ApplicationMailer
  def notify_question_owner(answer)
    @question = answer.question
    @answer = answer

    mail to: answer.question.user.email, subject: 'You get new answer for your question.'
  end

  def notify_about_new_answer(answer, user)
    @question = answer.question
    @answer = question.answers.last

    mail to: user.email, subject: 'You get new answer for subscribed question.'
  end
end
