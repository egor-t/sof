# frozen_string_literal: true

class DailyMailer < ApplicationMailer
  def digest(user)
    @questions = Question.where('created_at >= ?', 1.day.ago)

    mail(to: user.email, subject: 'Daily digest')
  end
end
