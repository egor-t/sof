# frozen_string_literal: true

module QuestionHelper
  def create_question(title, body, file_path = nil)
    fill_in 'Title', with: title
    fill_in 'Body', with: body
    attach_file 'File', file_path unless file_path.nil?
    click_on 'Create'
  end
end
