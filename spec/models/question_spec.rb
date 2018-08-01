require 'rails_helper'

RSpec.describe Question, type: :model do
  subject { build(:question) }

  it { should have_many :answers }
  it { should have_many :attachments }
  it { should accept_nested_attributes_for :attachments }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:body) }
  it { should have_many(:subscriptions).dependent(:destroy) }
end
