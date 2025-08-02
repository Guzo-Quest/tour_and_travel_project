require 'rails_helper'

RSpec.describe Api::V1::Review, type: :model do

  describe 'associations' do
    it { should belong_to(:tour) }
    it { should belong_to(:user) }
  end

  let(:tour) { create(:api_v1_tour) }
  let(:user) { create(:user) }
  let(:booking) { create(:api_v1_booking, tour: tour, user: user, booking_status: 'confirmed') }

  describe 'associations' do
    it "belongs to tour" do
      association = described_class.reflect_on_association(:tour)
      expect(association.macro).to eq :belongs_to
    end

    it "belongs to user" do
      association = described_class.reflect_on_association(:user)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe 'validations' do
    subject { build(:api_v1_review, tour: tour, user: user) }
    it { should validate_presence_of(:rating) }
    it { should validate_presence_of(:review_text) }
  end

  describe 'custom validations' do
    let(:tour) { create(:api_v1_tour) }
    let(:user) { create(:user) }
    let(:booking) { create(:api_v1_booking, tour: tour, user: user, booking_status: 'confirmed') }
    let(:review) { build(:api_v1_review, tour: tour, user: user) }

    it 'user can only review the tour if he has booked the tour and it is completed' do
      review.user = user
      review.tour = tour
      review.valid?
      expect(review.errors[:error]).to include("You can only review the tour if you have booked the tour and it is completed.")
    end

    it 'should validate user must have booked the tour' do
      review.user = user
      review.tour = tour
      review.valid?
      expect(review.errors[:error]).to include("You need to book the tour before reviewing.")
    end
  end
end
