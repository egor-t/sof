# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }
  let(:user) { create(:user) }

  before { sign_in user }

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:create_request) do
        post :create, params: { question_id: question, answer: attributes_for(:answer) }, format: :js
      end

      it 'saves the new question in the database' do
        expect { create_request }.to change(question.answers, :count).by(1)
      end

      it 'render a create view' do
        create_request
        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      let(:create_request) do
        post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) }, format: :js
      end

      it 'should does not save answer in database' do
        expect { create_request }.to_not change(Answer, :count)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:user_answer) { create(:answer, question: question, user: user) }
    let!(:user2_answer) { create(:answer, question: question) }

    it 'delete my answer' do
      expect do
        delete :destroy, params: { id: user_answer, question_id: question }
      end .to change(question.answers, :count).by(-1)
    end

    it 'redirect to show view after delete my answer' do
      delete :destroy, params: { id: user_answer, question_id: question }
      expect(response).to redirect_to question_path(question)
    end

    it 'delete foreign answer' do
      expect { delete :destroy, params: { id: user2_answer, question_id: question } }.to_not change(question.answers, :count)
    end
  end

  describe 'PATCH #update' do
    let!(:answer) { create :answer, question: question }
    context 'with valid attributes' do
      it 'should assigns the requested answer to @answer' do
        patch :update, params: { id: answer, question_id: question,
                                 answer: attributes_for(:answer) }, format: :js
        expect(assigns(:answer)).to eq answer
      end

      xit 'should update exist answer in database' do
        patch :update, params: { id: answer, question_id: question, answer: { body: 'NEW BODY' }, format: :js }
        answer.reload
        expect(answer.body).to eq 'NEW BODY'
      end
    end
  end
end
