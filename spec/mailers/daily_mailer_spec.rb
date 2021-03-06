# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyMailer, type: :mailer do
  describe 'digest' do
    let(:user) { create(:user) }
    let(:mail) { DailyMailer.digest(user) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Daily digest')
      expect(mail.to.first).to eq(user.email)
      expect(mail.from).to eq(['from@example.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hello, it is new digest for today.')
    end
  end
end
