require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to validate_presence_of :email }
  it { is_expected.to validate_presence_of :password }

  it { should have_many(:questions).dependent(:destroy) }
  it { should have_many(:answers).dependent(:destroy) }

  context '#author_of?' do
    let(:user) { create(:user) }

    let!(:some_answer) { create(:answer) }
    let!(:answer) { create(:answer, user: user)}

    it 'check owner answer' do
      expect(user.author_of?(answer)).to eq true
    end

    it 'check user is not author of some answer' do
      expect(user.author_of?(some_answer)).to eq false
    end
  end

end