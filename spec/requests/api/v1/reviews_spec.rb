require 'rails_helper'

RSpec.describe "Api::V1::Reviews", type: :request do
  let(:user) { create(:user) }
  let(:tour) { create(:api_v1_tour) }
  let(:user_headers) { user.create_new_auth_token }

  let(:valid_attributes) {
    {
      rating: 4,
      review_text: "Great tour experience"
    }
  }

  let(:invalid_attributes) {
    {
      rating: nil,
      review_text: nil
    }
  }

  before do
    # Book the tour and set status to completed
    create(:api_v1_booking, tour: tour, user: user, booking_status: "completed")
  end

  let(:valid_headers) {
    {
      "Content-type": "application/json",
      "uid": user_headers["uid"],
      "client": user_headers["client"],
      "access-token": user_headers["access-token"]
    }
  }

  describe "POST /api/v1/tours/:tour_id/reviews" do
    context "with valid parameters" do
      it "creates a new review for the specified tour" do
        expect {
          post "/api/v1/tours/#{tour.id}/reviews", params: { api_v1_review: valid_attributes }.to_json, headers: valid_headers
        }.to change(Api::V1::Review, :count).by(1)

        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid parameters" do
      it "does not create a new review for the specified tour if the user has not booked the tour" do
        expect {
          post "/api/v1/tours/#{tour.id}/reviews", params: { api_v1_review: invalid_attributes }.to_json, headers: valid_headers
        }.to change(Api::V1::Review, :count).by(0)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "GET /api/v1/tours/:tour_id/reviews" do
    it "returns a success response" do
      create(:api_v1_review, tour: tour, user: user)
      get "/api/v1/tours/#{tour.id}/reviews", headers: valid_headers
      expect(response).to be_successful
    end
  end

  describe "GET /api/v1/tours/:tour_id/reviews/:id" do
    it "returns a success response" do
      review = create(:api_v1_review, tour: tour, user: user)
      get "/api/v1/tours/#{tour.id}/reviews/#{review.id}", headers: valid_headers
      expect(response).to be_successful
    end
  end

  describe "PATCH /api/v1/tours/:tour_id/reviews/:id" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          rating: 5,
          review_text: "Excellent tour experience"
        }
      }

      it "updates the requested review" do
        review = create(:api_v1_review, tour: tour, user: user)
        patch "/api/v1/tours/#{tour.id}/reviews/#{review.id}", params: { api_v1_review: new_attributes }.to_json, headers: valid_headers
        review.reload
        expect(review.rating).to eq(5)
        expect(review.review_text).to eq("Excellent tour experience")
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the review" do
        review = create(:api_v1_review, tour: tour, user: user)
        patch "/api/v1/tours/#{tour.id}/reviews/#{review.id}", params: { api_v1_review: invalid_attributes }.to_json, headers: valid_headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when the user has not booked the tour" do
      it "returns an unprocessable entity response" do
        review = create(:api_v1_review, tour: tour, user: user)
        user.bookings.destroy_all

        patch "/api/v1/tours/#{tour.id}/reviews/#{review.id}", params: { api_v1_review: valid_attributes }.to_json, headers: valid_headers
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when the review does not exist" do
      it "returns a not found response" do
        patch "/api/v1/tours/#{tour.id}/reviews/100", params: { api_v1_review: valid_attributes }.to_json, headers: valid_headers
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when the tour does not exist" do
      it "returns a not found response" do
        patch "/api/v1/tours/100/reviews/1", params: { api_v1_review: valid_attributes }.to_json, headers: valid_headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "DELETE /api/v1/tours/:tour_id/reviews/:id" do
    it "deletes the requested review" do
      review = create(:api_v1_review, tour: tour, user: user)
      expect {
        delete "/api/v1/tours/#{tour.id}/reviews/#{review.id}", headers: valid_headers
      }.to change(Api::V1::Review, :count).by(-1)
    end

    context "when the user has not booked the tour" do
      it "returns an no content entity response" do
        review = create(:api_v1_review, tour: tour, user: user)
        user.bookings.destroy_all

        delete "/api/v1/tours/#{tour.id}/reviews/#{review.id}", headers: valid_headers
        expect(response).to have_http_status(:no_content)
      end
    end

    context "when the review does not exist" do
      it "returns a not found response" do
        delete "/api/v1/tours/#{tour.id}/reviews/100", headers: valid_headers
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when the tour does not exist" do
      it "returns a not found response" do
        delete "/api/v1/tours/100/reviews/1", headers: valid_headers
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "when the user has not booked the tour" do
    it "returns an unprocessable entity response" do
      user.bookings.destroy_all
      post "/api/v1/tours/#{tour.id}/reviews", params: { api_v1_review: valid_attributes }.to_json, headers: valid_headers
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
