FactoryBot.define do
  factory :api_v1_tour_date, class: 'Api::V1::TourDate' do
    start_date { Faker::Date.between(from: Date.today, to: 1.year.from_now)}
    end_date { Faker::Date.between(from: start_date, to: 1.year.from_now)}
    tour { create(:api_v1_tour)}
  end
end
