# frozen_string_literal: true

require 'acceptance/acceptance_helper'

feature 'Show question', '
  As a non-authenticated user,
  I want to see question,
  so I can see answers for that question
' do

  let(:user) { create(:user) }
  let!(:question1) { Question.create(title: 'Test1', body: 'Body1', user: user) }

  scenario 'As user get exist question' do
    visit question_path(question1)

    expect(page).to have_content('Test1')
    expect(page).to have_content('Body1')
  end
end
