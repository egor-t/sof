require 'rails_helper'

RSpec.describe AnswersController, type: :controller do
  let(:question) { create(:question) }


  describe 'GET #show' do
    let(:answer) { create(:answer, question: question) }

    before { get :show, params: { question_id: question, id: answer }}

    it 'should assigns the requested question to @question' do
      expect(assigns(:answer)).to eq answer
    end

    it 'should render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new, params: { question_id: question }}

    it 'should assigns a new Answer to @answer' do
      expect(assigns(:answer)).to be_a_new(Answer)
    end

    it 'should render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:create_request) { post :create, params: { question_id: question, answer: attributes_for(:answer) }}

      it 'should save the new question in the database' do
        expect{ create_request }.to change(question.answers, :count).by(1)
      end

      it 'should redirect to show view' do
        create_request
        expect(response).to redirect_to question_path(assigns(:question))
      end
    end

    context 'with invalid attributes' do
      let(:create_request) { post :create, params: { question_id: question, answer: attributes_for(:invalid_answer) }}

      it 'should does not save answer in database' do
        expect { create_request }.to_not change(Answer, :count)
      end

      it 'should redirect to new view' do
        create_request
        expect(response).to render_template :new
      end
    end
  end
end
