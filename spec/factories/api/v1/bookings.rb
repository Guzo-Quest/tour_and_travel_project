FactoryBot.define do
  factory :api_v1_booking, class: 'Api::V1::Booking' do
    user { build(:user) }
    tour { build(:api_v1_tour) }
    booking_status { "pending" }
  end
end
