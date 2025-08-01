require 'rails_helper'

RSpec.describe Api::V1::Booking, type: :model do
  let(:user) { create(:user) }
  let(:tour) { create(:api_v1_tour) }
  let(:booking) { create(:api_v1_booking, user: user, tour: tour) }

  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:tour) }
  end

  describe 'validations' do
    subject { booking }

    it { should validate_presence_of(:tour_id) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:booking_status) }
  end

  describe 'enums' do
    it { should define_enum_for(:booking_status).backed_by_column_of_type(:string) }
  end

  describe 'scopes' do
    describe 'by_user' do
      let!(:other_booking) { create(:api_v1_booking, user: user, tour: tour) }

      it 'returns bookings by user' do
        expect(described_class.by_user(user)).to include(booking, other_booking)
      end
    end
  end

  describe 'factory' do
    it 'is valid' do
      expect(booking).to be_valid
    end
  end

  describe 'enum' do
    it 'should have the correct enum values' do
      expect(described_class.booking_statuses.keys).to eq(%w[pending confirmed cancelled completed])
    end
  end
end
