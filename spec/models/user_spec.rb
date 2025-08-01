require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    let(:user) { build(:user) }

    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should allow_value('test@example.com').for(:email) }
    it { should_not allow_value('test').for(:email) }
    it { should validate_length_of(:password).is_at_least(6) }
    it { should validate_confirmation_of(:password) }
    it { should have_one(:profile).dependent(:destroy) }

    it 'validates uniqueness of email' do
      user = create(:user)
      duplicate_user = user.dup
      expect(duplicate_user).to_not be_valid
      duplicate_user.email = 'different_email@example.com'
      expect(duplicate_user).to be_valid
    end
  end
end
