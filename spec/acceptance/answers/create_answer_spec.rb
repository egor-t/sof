# frozen_string_literal: true

require 'acceptance/acceptance_helper'

feature 'Create answer to question', '
  As a user,
  I want to answer for the question,
  so I can solve problem of community
' do

  let(:question_owner) { create(:user) }
  let(:user) { create(:user) }
  let!(:question) { Question.create(title: 'Test1', body: 'Body1', user: question_owner) }

  scenario 'As an authenticated user answer to question with valid data', js: true do
    sign_in user

    visit question_path(question)

    fill_in 'Body', with: 'Perfect answer'
    click_on 'Answer it'

    within '.answers' do
      expect(page).to have_content('Perfect answer')
    end
    expect(current_path).to eq question_path(question)
  end

  scenario 'Authenticated user create answer with invalid data', js: true do
    sign_in(user)
    visit question_path(question)

    click_on 'Answer it'

    expect(page).to have_content("Body can't be blank")
  end

  scenario 'As non-authenticated user try to answer to question with valid data' do
    visit question_path(question)

    fill_in 'Body', with: 'Perfect answer'
    click_on 'Answer it'

    expect(page).to_not have_content('Answers')
    expect(page).to have_content('You need to sign in or sign up before continuing.')
    expect(current_path).to eq new_user_session_path
  end
end
