require 'rails_helper'

feature 'Show question', %q(
  As a non-authenticated user,
  I want to see question,
  so I can see answers for that question
) do

  let!(:question1) { Question.create(title: 'Test1', body: 'Body1') }

  scenario 'As user get exist question' do
    visit questions_path(question1)

    expect(page).to have_content('Test1')
    expect(page).to have_content('Body1')
  end
end