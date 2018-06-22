# frozen_string_literal: true

require 'acceptance/acceptance_helper'

feature 'Show all questions', '
  As a non-authenticated user,
  I want to see all questions,
  so I can get answer for my problem
' do

  let(:user) { create(:user) }
  let!(:question1) { Question.create(title: 'Test1', body: 'Body1', user: user) }
  let!(:question2) { Question.create(title: 'Test2', body: 'Body2', user: user) }

  scenario 'Authenticated user get all questions' do
    visit questions_path

    expect(page).to have_content('Test1')
    expect(page).to have_content('Test2')
    expect(page).to have_content('Body1')
    expect(page).to have_content('Body2')
  end
end
