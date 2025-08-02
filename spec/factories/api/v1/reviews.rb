FactoryBot.define do
  factory :api_v1_review, class: 'Api::V1::Review' do
    tour { build(:api_v1_tour) }
    user { build(:user) }
    rating { Faker::Number.between(from: 1, to: 5) }
    review_text { Faker::Lorem.paragraph(sentence_count: 2) }

  end
end
