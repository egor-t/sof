# frozen_string_literal: true

require 'rails_helper'

RSpec.describe NewAnswerJob, type: :job do
  let!(:answer) { create(:answer) }

  it 'should send email to question owner' do
    expect(QuestionMailer).to receive(:notify_question_owner).with(answer).and_call_original
    NewAnswerJob.perform_now(answer)
  end
end
