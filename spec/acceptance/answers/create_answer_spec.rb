require 'rails_helper'

feature 'Create answer to question', %q(
  As a user,
  I want to answer for the question,
  so I can solve problem of community
) do


  let(:question_owner) { create(:user) }
  let(:user) { create(:user) }
  let!(:question) { Question.create(title: 'Test1', body: 'Body1', user: question_owner) }

  scenario 'As an authenticated user answer to question with valid data' do
    sign_in user

    visit question_path(question)

    fill_in 'Body', with: 'Perfect answer'
    click_on 'Answer it'

    expect(page).to have_content('Perfect answer')
    expect(page).to have_content('Your answer was successfully created.')
    expect(current_path).to eq question_path(question)
  end

  scenario 'As an authenticated user answer to question with invalid data' do
    sign_in user

    visit question_path(question)

    fill_in 'Body', with: ''
    click_on 'Answer it'

    expect(page).to have_content("Body can't be blank")
    expect(current_path).to eq "#{question_path(question)}/answers"
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