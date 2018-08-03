# frozen_string_literal: true

require_relative '../acceptance_helper'

feature 'Add comment to question', '
  In order to ask questions about problem
  As a authenticate user
  I want to be able comment it
' do

  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  context 'As authenticated user' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    it 'try to add comment', js: true do
      within '.question-comment-form' do
        fill_in 'comment_body', with: 'New comment'
        click_on 'Comment it'
      end
      within '.question-comments' do
        expect(page).to have_content 'New comment'
      end
    end
  end

  context 'As not authenticated user' do
    background { visit question_path(question) }

    it 'try to comment it' do
      expect(page).to_not have_content 'Comment it'
    end
  end

  context 'multiple sessions' do
    scenario 'comment should appear for question page for another user', js: true do
      Capybara.using_session('user') do
        sign_in(user)
        visit question_path(question)
      end
      Capybara.using_session('guest') do
        visit question_path(question)
      end
      Capybara.using_session('user') do
        within '.question-comment-form' do
          fill_in 'comment_body', with: 'New comment'
          click_on 'Comment it'
        end
      end
      Capybara.using_session('guest') do
        within '.question-comments' do
          expect(page).to have_content 'New comment'
        end
      end
    end
  end
end
