require 'rails_helper'

feature 'Create question', %q(
  As an authenticated user,
  I want to create question,
  so I can get answer for my problem
) do

  let(:user) { create(:user) }

  scenario 'Authenticated user create question' do
    sign_in user

    visit '/questions'
    click_on 'Ask question'

    fill_in 'Title', with: 'Test question'
    fill_in 'Body', with: 'Some problem'
    click_on 'Create'

    expect(page).to have_content 'Your question was successfully created.'
  end

  scenario 'Non-authenticated user try to create question' do
    visit '/questions'
    click_on 'Ask question'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end
end