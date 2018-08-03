# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Answer, type: :model do
  it { should have_many :attachments }
  it { should have_many(:comments).dependent(:destroy) }
  it { should belong_to :question }
  it { should validate_presence_of(:body) }
  it { should accept_nested_attributes_for :attachments }

  describe 'mail notification' do
    context 'about new answer for question subscribers' do
      let(:user) { create(:user) }
      let!(:question) { create(:question) }

      subject { build(:answer, question: question) }

      it 'should send mail after answer create' do
        expect(SubscribedQuestionJob).to receive(:perform_later).with(subject)
        subject.save!
      end
    end

    context 'about new answer for question owner without subscription' do
      let(:user) { create(:user) }
      let!(:question) { create(:question, user: user) }

      subject { build(:answer, question: question) }

      it 'shoud not send mail after answer create' do
        expect(NewAnswerJob).not_to receive(:perform_later).with(subject)
        subject.save!
      end
    end

    context 'about new answer for question owner with subscription' do
      let(:user) { create(:user) }
      let(:question) { create(:question, user: user) }
      let!(:subscription) { create(:subscription, user: user, question: question) }

      subject { build(:answer, question: question) }

      it 'shoud send mail after answer create' do
        expect(NewAnswerJob).to receive(:perform_later).with(subject)
        subject.save!
      end
    end
  end
end
