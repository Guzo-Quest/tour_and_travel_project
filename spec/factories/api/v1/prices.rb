FactoryBot.define do
  factory :api_v1_price, class: 'Api::V1::Price' do
    price { Faker::Number.decimal(l_digits: 2) }
    currency { Faker::Currency.code }
    tour { create(:api_v1_tour)}
  end
end
