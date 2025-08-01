require 'rails_helper'

RSpec.describe "/api/v1/profiles", type: :request do
  let(:user) { create(:user) }
  let(:admin) { create(:admin) }
  let(:profile) { create(:profile, user: user) }
  let(:valid_attributes) {
    {
      profile: {
        first_name: "John",
        last_name: "Doe",
        phone_number: "0914604679",
        passport: "AB123456",
        profile_picture: "https://example.com/profile_picture.jpg"
      }
    }
  }

  let(:invalid_attributes) {
    {
      profile: {
        first_name: nil,
        last_name: nil,
        phone_number: nil,
        passport: nil,
        profile_picture: nil
      }
    }
  }

  let(:user_headers) { user.create_new_auth_token }
  let(:admin_headers) { admin.create_new_auth_token }
  let(:valid_user_headers) {
    {
      'Content-Type': 'application/json',
      'access-token': user_headers['access-token'],
      'uid': user_headers['uid'],
      'client': user_headers['client']
    }
  }

  let(:valid_admin_headers) {
    {
      'Content-Type': 'application/json',
      'access-token': admin_headers['access-token'],
      'uid': admin_headers['uid'],
      'client': admin_headers['client']
    }
  }

  describe "GET /api/v1/profiles" do
    it "renders a successful response" do
      get api_v1_profiles_url, headers: valid_admin_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /api/v1/profile" do
    it "renders a successful response" do
      get api_v1_profile_url(profile), headers: valid_user_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /api/v1/profile" do
    context "with valid parameters" do
      it "creates a new profile" do
        expect {
          post api_v1_profile_url, params: valid_attributes, headers: valid_user_headers, as: :json
        }.to change(Profile, :count).by(1)
      end

      it "renders a JSON response with the new profile" do
        post api_v1_profile_url, params: valid_attributes, headers: valid_user_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new profile" do
        expect {
          post api_v1_profile_url, params: invalid_attributes, headers: valid_user_headers, as: :json
        }.to change(Profile, :count).by(0)
      end

      it "renders a JSON response with errors for the new profile" do
        post api_v1_profile_url, params: invalid_attributes, headers: valid_user_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /api/v1/profile" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          profile: {
            first_name: "Jane"
          }
        }
      }

      it "updates the requested profile" do
        patch api_v1_profile_url(profile), params: new_attributes, headers: valid_user_headers, as: :json
        profile.reload
        expect(profile.first_name).to eq("Jane")
      end

      it "renders a JSON response with the updated profile" do
        patch api_v1_profile_url(profile), params: new_attributes, headers: valid_user_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the profile" do
        patch api_v1_profile_url(profile), params: invalid_attributes, headers: valid_user_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /api/v1/profile" do
    it "destroys the requested profile" do
      profile # Create the profile
      expect {
        delete api_v1_profile_url(profile), headers: valid_user_headers, as: :json
      }.to change(Profile, :count).by(-1)
    end
  end
end
