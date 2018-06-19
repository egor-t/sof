module AnswersHelper
  def show_error_messages(answer)
    data = ""
    answer.errors.full_messages.each do |message|
      data << "#{ j message }"
      data << '<br/>'
    end
    data.html_safe
  end
end
