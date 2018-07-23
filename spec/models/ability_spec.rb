require 'rails_helper'

describe Ability do
  subject(:ability) { Ability.new(user) }

  describe 'for guest' do
    let(:user) { nil }

    it { should be_able_to :read, Question }
    it { should be_able_to :read, Answer }
    it { should be_able_to :read, Comment }

    it { should_not be_able_to :manage, :all }
  end

  describe 'for user' do
    let(:user) { create(:user) }
    let(:other_user) { create(:user) }

    let(:question) { create(:question, user: user) }
    let(:second_question) { create(:question, user: other_user) }

    let(:answer) { create :answer, user: user, question: question }
    let(:other_answer) { create :answer, user: other_user, question: question }

    context 'Question' do
      it { should be_able_to :create, Question }
      it { should be_able_to :update, question , user: user }
      it { should_not be_able_to :update, second_question, user: user }

      it { should be_able_to :like, second_question, user: user }
      it { should be_able_to :dislike, second_question, user: user }

      xit 'should not be able to like own question' do
        should_not be_able_to :like, question, user: user
      end
    end

    context 'Answer' do
      it { should be_able_to :destroy, answer, user: user }
      it { should_not be_able_to :destroy, other_answer, user: user }
  
      it { should be_able_to :best_answer, answer, user: user }
      it { should_not be_able_to :best_answer, other_answer, user: user }
  
      it { should be_able_to :like, other_answer, user: user }
      it { should be_able_to :dislike, other_answer, user: user }
    end

    context 'Comment' do
      it { should be_able_to :create, Comment }
    end
  end
end
