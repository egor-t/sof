require 'rails_helper'

feature 'User sign in', %q(
  As a user,
  I want to be able sign in,
  so I can to ask question
) do

  let(:user) { create(:user) }

  scenario 'Registered user try to sign in' do
    sign_in user

    expect(page).to  have_content('Signed in successfully.')
    expect(current_path).to eq root_path
  end

  scenario 'Not-registered user try to sign in' do
    visit new_user_session_path

    fill_in 'Email', with: 'wrong@user.com'
    fill_in 'Password', with: '12345'
    click_on 'Log in'

    expect(page).to  have_content('Invalid Email or password.')
    expect(current_path).to eq new_user_session_path
  end
end