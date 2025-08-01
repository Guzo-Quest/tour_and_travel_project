require 'rails_helper'

RSpec.describe Api::V1::TourDate, type: :model do

  describe "Associations" do
    it { should belong_to(:tour) }
  end

  describe "Validations" do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
  end

  describe "Custom Validations" do
    it "start_date_cannot_be_in_the_past" do
      tour_date = Api::V1::TourDate.new(start_date: Date.today - 1)
      tour_date.valid?
      expect(tour_date.errors[:start_date]).to include("can't be in the past")
    end

    it "end_date_cannot_be_in_the_past" do
      tour_date = Api::V1::TourDate.new(end_date: Date.today - 1)
      tour_date.valid?
      expect(tour_date.errors[:end_date]).to include("can't be in the past")
    end

    it "end_date_cannot_be_before_start_date" do
      tour_date = Api::V1::TourDate.new(start_date: Date.today, end_date: Date.today - 1)
      tour_date.valid?
      expect(tour_date.errors[:end_date]).to include("can't be before the start date")
    end
  end

end
