require 'rails_helper.rb'

describe 'Profile API' do
  let(:me) { create(:user) }

  describe 'GET /me' do 
    context 'unauthorized' do
      it 'return 401 status if the is no access token' do 
        get '/api/v1/profiles/me', params: { format: :json }
        expect(response.status).to eq 401
      end

      it 'return 401 status if the is invalid acsess token' do 
        get '/api/v1/profiles/me', params: { format: :json, access_token: '1234' }
        expect(response.status).to eq 401
      end
    end

    context 'authorized' do
      let(:access_token) { create(:access_token, resource_owner_id: me.id) }

      before { get '/api/v1/profiles/me', params: { format: :json, access_token: access_token.token } }

      it 'return 200 status' do
        expect(response).to be_success
      end

      it 'contain email' do
        expect(response.body).to be_json_eql(me.email.to_json).at_path('email')
      end

      it 'contain id' do
        expect(response.body).to be_json_eql(me.id.to_json).at_path('id')
      end

      %w(password encrypted_password).each do |attr|
        it "does not contain #{attr}" do
          expect(response.body).to_not have_json_path(attr)
        end
      end
    end

    describe 'GET /users' do
      context 'unauthorized' do
        it 'return 401 status if the is no access token' do 
          get '/api/v1/profiles', params: { format: :json }
          expect(response.status).to eq 401
        end
  
        it 'return 401 status if the is invalid acsess token' do 
          get '/api/v1/profiles', params: { format: :json, access_token: '1234' }
          expect(response.status).to eq 401
        end
      end
      
      context 'authorized' do
        let!(:users) { create_list(:user, 2) }
        let(:access_token) { create(:access_token, resource_owner_id: me.id) }

        before { get '/api/v1/profiles', params: { format: :json, access_token: access_token.token } }

        it 'return all users without current' do
          expect(response.body).to eq(users.to_json)
        end
      end
    end
  end
end