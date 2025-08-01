require "rails_helper"

RSpec.describe Api::V1::ToursController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/api/v1/tours").to route_to("api/v1/tours#index")
    end

    it "routes to #show" do
      expect(get: "/api/v1/tours/1").to route_to("api/v1/tours#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/api/v1/tours").to route_to("api/v1/tours#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/api/v1/tours/1").to route_to("api/v1/tours#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/api/v1/tours/1").to route_to("api/v1/tours#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/api/v1/tours/1").to route_to("api/v1/tours#destroy", id: "1")
    end
  end
end
