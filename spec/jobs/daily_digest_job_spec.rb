# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DailyDigestJob, type: :job do
  let(:user) { create :user }

  it 'should perform delivery' do
    allow(DailyMailer).to receive(:digest).with(user).and_call_original
    DailyDigestJob.perform_now
  end
end
