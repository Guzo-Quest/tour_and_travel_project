FactoryBot.define do
  factory :admin do
    email { Faker::Internet.email }
    password { Faker::Internet.password }
    password_confirmation { password }
    provider { 'email' }
    uid { email } # Provide a valid value for the uid attribute
  end
end
