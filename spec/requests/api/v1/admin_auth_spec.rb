# spec/requests/api/v1/Admin_auth_spec.rb

require 'rails_helper'
RSpec.describe 'API::V1::AdminAuth', type: :request do
  let (:admin) { create(:admin) }

  describe 'POST /api/v1/Admin_auth/sign_in' do
    it 'should return authentication headers on successful sign in' do
      post '/api/v1/Admin_auth/sign_in', params: { email: admin.email, password: admin.password }
      expect(response).to have_http_status(:success)
      expect(response.headers.keys).to include('client', 'access-token', 'uid')
    end

    it 'should return unauthorized status with invalid credentials' do
      post '/api/v1/Admin_auth/sign_in', params: { email: 'invalid@example.com', password: 'invalidpassword' }

      expect(response).to have_http_status(:unauthorized)
    end

    it 'returns unauthorized status with empty request' do
      post '/api/v1/Admin_auth/sign_in', params: {}
      expect(response).to have_http_status(:unauthorized)
    end

  end

  describe 'POST /api/v1/Admin_auth/sign_out' do
    it 'should sign out the admin' do
      post '/api/v1/Admin_auth/sign_in', params: { email: admin.email, password: admin.password }
      auth_headers = {
        'uid' => response.headers['uid'],
        'client' => response.headers['client'],
        'access-token' => response.headers['access-token']
      }

      delete '/api/v1/Admin_auth/sign_out', headers: auth_headers

      expect(response).to have_http_status(:success)
    end

    it 'returns unauthorized status without authentication headers' do
      delete '/api/v1/Admin_auth/sign_out', headers: {}
      expect(response).to have_http_status(:not_found)
      expect(response.body).to include('User was not found or was not logged in.')

    end

  end

  describe 'POST /api/v1/Admin_auth' do
    it 'registers a new admin' do
      admin_attributes = attributes_for(:admin)
      post '/api/v1/Admin_auth', params: admin_attributes
      expect(response).to have_http_status(:success)
      expect(response.headers.keys).to include('client', 'access-token', 'uid')
    end

    it 'returns unprocessable_entity status with invalid admin attributes' do
      post '/api/v1/Admin_auth', params: { admin: { email: '', password: 'password' } }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

end
