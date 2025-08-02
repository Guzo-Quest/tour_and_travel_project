FactoryBot.define do
  factory :api_v1_cancellation, class: 'Api::V1::Cancellation' do
    booking { build(:api_v1_booking) }
    reason { Faker::Lorem.sentence }
  end
end
