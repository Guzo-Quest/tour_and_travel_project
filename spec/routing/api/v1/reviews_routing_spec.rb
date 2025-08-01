require 'rails_helper'

RSpec.describe "Api::V1::Reviews Routing", type: :routing do
  describe "nested routes under tours" do
    it "routes GET /api/v1/tours/:tour_id/reviews to api/v1/reviews#index" do
      expect(get: "/api/v1/tours/1/reviews").to route_to(
        controller: "api/v1/reviews",
        action: "index",
        tour_id: "1"
      )
    end

    it "routes POST /api/v1/tours/:tour_id/reviews to api/v1/reviews#create" do
      expect(post: "/api/v1/tours/1/reviews").to route_to(
        controller: "api/v1/reviews",
        action: "create",
        tour_id: "1"
      )
    end

    it "routes GET /api/v1/tours/:tour_id/reviews/:id to api/v1/reviews#show" do
      expect(get: "/api/v1/tours/1/reviews/2").to route_to(
        controller: "api/v1/reviews",
        action: "show",
        tour_id: "1",
        id: "2"
      )
    end

    it "routes PATCH /api/v1/tours/:tour_id/reviews/:id to api/v1/reviews#update" do
      expect(patch: "/api/v1/tours/1/reviews/2").to route_to(
        controller: "api/v1/reviews",
        action: "update",
        tour_id: "1",
        id: "2"
      )
    end

    it "routes PUT /api/v1/tours/:tour_id/reviews/:id to api/v1/reviews#update" do
      expect(put: "/api/v1/tours/1/reviews/2").to route_to(
        controller: "api/v1/reviews",
        action: "update",
        tour_id: "1",
        id: "2"
      )
    end

    it "routes DELETE /api/v1/tours/:tour_id/reviews/:id to api/v1/reviews#destroy" do
      expect(delete: "/api/v1/tours/1/reviews/2").to route_to(
        controller: "api/v1/reviews",
        action: "destroy",
        tour_id: "1",
        id: "2"
      )
    end
  end


end
