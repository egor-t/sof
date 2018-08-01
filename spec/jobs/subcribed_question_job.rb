require 'rails_helper'

RSpec.describe SubscribedQuestionJob, type: :job do
  let!(:answer) { create(:answer) }

  it 'should send email to question owner' do
    expect(QuestionMailer).to receive(:notify_about_new_answer).with(answer).and_call_original
    SubscribedQuestionJob.perform_now(answer)
  end
end
