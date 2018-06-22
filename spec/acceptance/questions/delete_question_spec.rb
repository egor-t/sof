# frozen_string_literal: true

require 'acceptance/acceptance_helper'

feature 'User delete question', '
  In order to destroy question
  As an author
  I want destroy only my questions
' do

  let(:owner) { create(:user) }
  let(:regular_user) { create(:user) }

  context 'As an author' do
    before { sign_in(owner) }
    let!(:owner_question) { create(:question, user: owner) }

    scenario 'delete own question' do
      visit question_path(owner_question)
      click_on 'Delete'

      expect(current_path).to eq questions_path
      expect(all('.question').count).to eq 0
    end
  end

  context 'As regular user' do
    before { sign_in(owner) }
    let!(:question) { create(:question, user: regular_user, title: 'Delete') }

    scenario 'try delete foreign question' do
      visit question_path(question)

      expect(page).to_not have_link 'Delete'
    end
  end
end
