require 'rails_helper'

RSpec.describe Api::V1::Tour, type: :model do
  describe "associations" do
    it { should belong_to(:category) }
    it { should belong_to(:admin) }
    it { should have_many(:tour_dates).dependent(:destroy) }
    it { should have_many(:prices).dependent(:destroy) }
    it { should have_many(:destinations).dependent(:destroy) }
    it { should have_many(:activities).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:duration) }
    it "validates uniqueness of name" do
      tour = create(:api_v1_tour)
      duplicate_tour = build(:api_v1_tour, name: tour.name)
      expect(duplicate_tour).not_to be_valid
    end

    it { should validate_numericality_of(:duration).only_integer.is_greater_than(0) }
  end

  describe "nested attributes" do
    it { should accept_nested_attributes_for(:tour_dates).allow_destroy(true) }
    it { should accept_nested_attributes_for(:prices).allow_destroy(true) }
    it { should accept_nested_attributes_for(:destinations).allow_destroy(true) }
    it { should accept_nested_attributes_for(:activities).allow_destroy(true) }
  end

# check if the factory bot is overriding attributes im passing in the test
  describe "factory" do
    it "is should create a tour with specified attributes" do
      tour = create(:api_v1_tour, name: "New Tour", duration: 5, description: "New Tour Description")
      expect(tour.name).to eq("New Tour")
      expect(tour.duration).to eq(5)
      expect(tour.description).to eq("New Tour Description")
    end
  end

end
