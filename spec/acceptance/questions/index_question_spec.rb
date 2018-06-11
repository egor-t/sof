require 'rails_helper'

feature 'Show all questions', %q(
  As a non-authenticated user,
  I want to see all questions,
  so I can get answer for my problem
) do

  let!(:question1) { Question.create(title: 'Test1', body: 'Body1') }
  let!(:question2) { Question.create(title: 'Test2', body: 'Body2') }

  scenario 'Authenticated user get all questions' do
    visit questions_path

    expect(page).to have_content('Test1')
    expect(page).to have_content('Test2')
    expect(page).to have_content('Body1')
    expect(page).to have_content('Body2')
  end
end