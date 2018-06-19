require 'acceptance/acceptance_helper'

feature 'Delete answer to question', %q(
  As a user,
  I want to delete the answer for the question,
  so I can change my mind about answer
) do


  let(:question_owner) { create(:user) }
  let(:answer_owner) { create(:user) }
  let(:user) { create(:user) }
  let!(:question) { Question.create(title: 'Test1', body: 'Body1', user: question_owner) }
  let!(:answer) { create(:answer, question: question, user: answer_owner) }

  context 'As an author delete answer' do
    before { sign_in(answer_owner) }

    scenario 'delete own question' do
      visit question_path(question)
      click_on 'Delete answer'

      expect(current_path).to eq question_path(question)
      expect(all('.question').count).to eq 0
    end
  end

  context 'As regular user delete the some answer' do
    before { sign_in(question_owner) }

    scenario 'try delete foreign question' do
      visit question_path(question)

      expect(page).to_not have_link 'Delete answer'
    end
  end
end