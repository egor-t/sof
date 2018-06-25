
require 'acceptance/acceptance_helper'

feature 'Add files to answer', '
  As an answer author,
  I want to upload some file,
  so I can solve the problem in details
' do

  let(:user) { create :user }
  let(:question) { create :question }

  before do
    sign_in user
    visit question_path(question)
  end

  describe 'User can add the file when create his question', js: true do
    let(:file_path) { "#{Rails.root}/spec/spec_helper.rb" }

    it 'should create answer with file' do
      within '#new_answer' do
        fill_in 'Body', with: 'Perfect answer'
        attach_file 'File', file_path
        click_on 'Answer it'
      end

      save_and_open_page


      within '.answers' do
        expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
      end
    end
  end
end