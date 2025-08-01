FactoryBot.define do
  factory :api_v1_activity, class: 'Api::V1::Activity' do
    name { Faker::Name.unique.name }
    tour { create(:api_v1_tour)}
  end
end
