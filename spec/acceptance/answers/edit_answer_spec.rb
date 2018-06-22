require 'acceptance/acceptance_helper'

feature 'Answer editing', %q(
  As a author of answer,
  I want to edit my answer,
  so I can fix mistake
) do
  let(:question_owner) { create(:user) }
  let(:answer_user) { create(:user) }
  let(:question) { Question.create(title: 'Test1', body: 'Body1', user: question_owner) }
  let!(:answer) { create :answer, question: question, user: answer_user }


  scenario 'Unauthenticated user try to edit the answer' do
    visit question_path(question)

    expect(page).to_not have_link('Edit answer')
  end

  scenario 'Authenticated user(not an owner of answer) try to edit the question' do
    sign_in(question_owner)
    visit question_path(question)

    expect(page).not_to have_link('Edit answer')
  end


  describe 'Authenticated user(owner)', js: true do
    before do
      sign_in(answer_user)
      visit question_path(question)
    end

    scenario 'should see edit answer link' do
      within '.answers' do
        expect(page).to have_link('Edit answer')
      end
    end

    scenario 'should see fixed answer after updated'  do
      click_on 'Edit answer'

      # save_and_open_page?

      within '.edit_answer' do
        fill_in 'Answer', with: 'edited answer'
        click_on 'Save answer'
      end


      within '.answers' do
        expect(page).to have_content('edited answer')
        expect(page).not_to have_content(answer.body)
      end
    end
  end
end