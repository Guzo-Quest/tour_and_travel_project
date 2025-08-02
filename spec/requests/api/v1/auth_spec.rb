require 'rails_helper'

RSpec.describe 'API::V1::Auth', type: :request do
  let(:user) { create(:user) }

  describe 'POST /api/v1/auth/sign_in' do


    it 'should return unauthorized status with invalid credentials' do
      post '/api/v1/auth/sign_in', params: { email: 'invalid@example.com', password: 'invalidpassword' }
      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns unauthorized status with empty request' do
      post '/api/v1/auth/sign_in', params: {}
      expect(response).to have_http_status(:unauthorized)
    end
  end



  describe 'POST /api/v1/auth' do


    it 'returns unprocessable_entity status with invalid user attributes' do
      post '/api/v1/auth', params: { user: { email: '', password: 'password' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
