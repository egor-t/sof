require 'acceptance/acceptance_helper'

feature 'User sign out', %q(
  As an authenticated user,
  I want to be able sign out,
  so I can to finish my session
) do

  let(:user) { create(:user) }

  scenario 'Authenticated user try to sign out' do
    sign_in user

    click_on 'Sign out'

    expect(page).to  have_content('Signed out successfully.')
    expect(current_path).to eq root_path
  end
end