# frozen_string_literal: true

module QuestionHelper
  def create_question(title, body)
    fill_in 'Title', with: title
    fill_in 'Body', with: body
    click_on 'Create'
  end
end
