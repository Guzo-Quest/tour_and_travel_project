FactoryBot.define do
  factory :api_v1_destination, class: 'Api::V1::Destination' do
    name { Faker::Name.unique.name }
    description { Faker::Lorem.paragraph }
    tour { create(:api_v1_tour)}
  end
end
