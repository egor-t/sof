# frozen_string_literal: true

require 'acceptance/acceptance_helper'

feature 'Create question', '
  As an authenticated user,
  I want to create question,
  so I can get answer for my problem
' do

  let(:user) { create(:user) }

  # Form elements
  let(:ask_question) { 'Ask question' }

  scenario 'Authenticated user create question' do
    sign_in user

    visit questions_path

    click_on ask_question

    fill_in 'Title', with: title
    fill_in 'Body', with: body
    click_on 'Create'

    expect(page).to have_content 'Your question was successfully created.'
  end

  scenario 'Non-authenticated user try to create question' do
    visit questions_path
    click_on ask_question

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  context 'multiple sessions' do
    scenario "question appears on another user's page", js: true do
      Capybara.using_session('user') do
        sign_in user
        visit questions_path
      end

      Capybara.using_session('guest') do
        visit questions_path
      end

      Capybara.using_session('user') do
        click_on ask_question
        create_question 'New question', 'New body'

        expect(page).to have_content 'Your question was successfully created.'
      end

      Capybara.using_session('guest') do
        expect(page).to have_content 'New question'
      end

    end
  end
end
