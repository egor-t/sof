require 'rails_helper'

RSpec.describe Questions::CommentsController, type: :controller do

  describe '#POST create' do
    let(:user) { create(:user) }
    before { sign_in user }

    let(:question) { create(:question) }
    let(:create_response) { JSON.parse(response.body) }

    context 'with valid attributes' do
      let(:valid_create_request) { post :create,
                                        params: { question_id: question.id, comment: { body: 'New comment' }, format: :json }
      }

      it 'should return status OK' , js: true do
        valid_create_request
        expect(response).to have_http_status :ok
      end

      it 'should change in db comment count', js: true do
        expect { valid_create_request }.to change(question.comments, :count).by(1)
      end

      it 'shout return json with body attribute', js: true do
        valid_create_request
        expect(create_response['body']).to eq 'New comment'
      end
    end

    context 'with invalid attributes' do
      let(:invalid_create_request) { post :create,
                                          params: { question_id: question.id, comment: { body: '' }, format: :json }
      }

      it 'return status unprocessable_entity and code 422' do
        invalid_create_request
        expect(response).to have_http_status :unprocessable_entity
      end

      it 'should not change count comment in db' do
        expect { invalid_create_request }.to_not change(Comment, :count)
      end
    end
  end

end
