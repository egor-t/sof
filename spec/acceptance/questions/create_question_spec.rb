require 'rails_helper'

feature 'Create question', %q(
  As an authenticated user,
  I want to create question,
  so I can get answer for my problem
) do

  let(:user) { create(:user) }

  # Form elements
  let(:ask_question) { 'Ask question' }

  scenario 'Authenticated user create question' do
    sign_in user

    visit questions_path
    click_on ask_question
    # Question helper
    create_question('Test question', 'Some problem')

    expect(page).to have_content 'Your question was successfully created.'
  end

  scenario 'Non-authenticated user try to create question' do
    visit questions_path
    click_on ask_question

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end