# frozen_string_literal: true

module AnswersHelper
  def show_error_messages(answer)
    data = ''
    answer.errors.full_messages.each do |message|
      data += message.dup
      data += '<br/>'
    end
    data.html_safe
  end
end
