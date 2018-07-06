
require 'acceptance/acceptance_helper'

feature 'Add files to question', '
  As an question author,
  I want to upload some file,
  so I can show problem in details
' do

  let(:user) { create :user }

  before do
    sign_in user
    visit new_question_path
  end

  describe 'User can add the file when create his question' do
    let(:file_path) { "#{Rails.root}/spec/spec_helper.rb" }

    it 'should create question with file' do
      create_question('Test question', 'Some problem', file_path)

      expect(page).to have_content 'Question was successfully created.'
      expect(page).to have_link 'spec_helper.rb', href: '/uploads/attachment/file/1/spec_helper.rb'
    end
  end
end