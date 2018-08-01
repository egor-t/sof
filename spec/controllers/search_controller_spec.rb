require 'rails_helper'

RSpec.describe SearchController, type: :controller do
  describe 'GET #index without params' do
    before { get :index }

    it 'should render index' do
      expect(response).to render_template :index
    end
  end

  describe 'POST #index with params' do
    let!(:user) { create :user }
    let!(:question) { create :question, body: 'ALOHA', user: user }
    let(:answer) { create :answer, user: @user, question: question }
    let(:comment) { create :comment, user: @user, commentable_type: 'Question', commentable_id: question.id }

    before { get :index, params: { object_type: 'Question', query: 'ALOHA' } }

    it 'should render index' do
      expect(response).to render_template :index
    end

    xit 'should return question', sphinx: true do
      expect(assigns(:search_result)).to eq(question)
    end
  end
end
