# frozen_string_literal: true

require 'acceptance/acceptance_helper'

feature 'Make favorite answer for question', '
  As a author of question
  I want to choose favorite answer,
  so I can finish my problem
' do

  let(:user) { create(:user) }
  let(:owner_question) { create(:user) }
  let!(:question) { create(:question, user: owner_question) }
  let!(:answer1) { create(:answer, question: question) }

  describe 'As authenticated user', js: true do
    it 'owner choose favorite answer for his question' do
      sign_in(owner_question)
      visit question_path(question)

      within '.answers' do
        click_on 'Best answer'
      end

      within '.answer' do
        expect(page).to have_content('That is the best answer')
      end
    end

    it 'only owner should see the button - best answer' do
      sign_in user
      visit question_path(question)

      expect(page).not_to have_content('Best answer')
    end
  end

  describe 'As non-authenticated user' do
    it 'only owner should see the button - best answer' do
      visit question_path(question)

      expect(page).not_to have_content('Best answer')
    end
  end
end
