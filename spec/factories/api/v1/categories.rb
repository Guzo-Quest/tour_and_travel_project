FactoryBot.define do
  factory :api_v1_category, class: 'Api::V1::Category' do
    name { Faker::Name.unique.name }
  end
end
