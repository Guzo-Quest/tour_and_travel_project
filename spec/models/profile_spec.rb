require 'rails_helper'

RSpec.describe Profile, type: :model do

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_presence_of(:passport) }
    it { should validate_length_of(:phone_number).is_at_least(10).is_at_most(13) }
    it { should belong_to(:user) }
    it 'validates uniqueness of phone_number' do
      FactoryBot.create(:profile, phone_number: '1234567890')
      should validate_uniqueness_of(:phone_number).case_insensitive
    end
  end
end
