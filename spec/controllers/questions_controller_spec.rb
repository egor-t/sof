require 'rails_helper'

RSpec.describe QuestionsController, type: :controller do
  let(:user) { create(:user) }
  let(:question) { create(:question, user: user) }

  before { sign_in user }

  describe 'GET #index' do
    let(:questions) { create_list(:question, 2) }

    before { get :index }

    it 'should populates an array of all questions' do
      expect(assigns(:questions)).to match_array(questions)
    end

    it 'should render index view' do
      expect(response).to render_template :index
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: question } }

    it 'should assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'should render show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    before { get :new }

    it 'should assigns a new Question to @question' do
      expect(assigns(:question)).to be_a_new(Question)
    end

    it 'should render new view' do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before { get :edit, params: { id: question } }

    it 'should assigns the requested question to @question' do
      expect(assigns(:question)).to eq question
    end

    it 'should render edit view' do
      expect(response).to render_template :edit
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'should save new question in database' do
        # question
        expect { post :create, params: { question: attributes_for(:question) } }.to change(Question, :count).by(1)
      end

      it 'should redirect to show view' do
        post :create, params: { question: attributes_for(:question) }
        expect(response).to redirect_to question_path(id: Question.last)
      end
    end

    context 'with invalid attributes' do
      it 'should does not save the question' do
        expect { post :create, params: { question: attributes_for(:invalid_question) } }.to_not change(Question, :count)
      end

      it 'should render new view' do
        post :create, params: { question: attributes_for(:invalid_question) }
        expect(response).to render_template :new
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid attributes' do
      it 'should assigns the requested question to @question' do
        patch :update, params: { id: question, question: attributes_for(:question) }
        expect(assigns(:question)).to eq question
      end

      it 'should update exist question in database' do
        patch :update, params: { id: question, question: { title: 'NEW TITLE', body: 'NEW BODY' } }
        question.reload
        expect(question.title).to eq 'NEW TITLE'
        expect(question.body).to eq 'NEW BODY'
      end

      it 'should redirected to updated question - show view' do
        patch :update, params: { id: question, question: attributes_for(:question) }
        expect(response).to redirect_to question_path(id: Question.last)
      end
    end

    context 'with invalid attributes' do
      before { patch :update, params: { id: question, question: { title: 'NEW TITLE', body: '' } } }

      it 'should not update exist question in database' do
        question.reload
        expect(question.title).to eq 'MyString'
        expect(question.body).to eq 'MyText'
      end

      it 'should render edit view' do
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before { question }

    it 'deletes question' do
      expect { delete :destroy, params: { id: question.id } }.to change(Question, :count).by(-1)
    end

    it 'should redirect to index page' do
      delete :destroy, params: { id: question }
      expect(response).to redirect_to questions_path
    end
  end
end
