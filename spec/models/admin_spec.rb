require 'rails_helper'

RSpec.describe Admin, type: :model do
  describe 'validations' do
    let(:admin) { build(:admin) }
    it { should validate_presence_of(:email) }
    it { should allow_value('valid_email@example.com').for(:email) }
    it { should_not allow_value('invalid_email').for(:email) }
  end

    it 'validates uniqueness of email' do
      admin = create(:admin)
      duplicate_admin = admin.dup
      expect(duplicate_admin).to_not be_valid
      duplicate_admin.email = 'different_email@example.com'
      expect(duplicate_admin).to be_valid
    end

  describe 'devise modules' do
    it { should have_db_column(:email).of_type(:string)}
    it { should have_db_column(:encrypted_password).of_type(:string).with_options(null: false, default: "") }
    it { should have_db_column(:reset_password_token).of_type(:string) }
    it { should have_db_column(:reset_password_sent_at).of_type(:datetime) }
    it { should have_db_column(:remember_created_at).of_type(:datetime) }
    it { should have_db_index(:email).unique }
    it { should have_db_index(:reset_password_token).unique }
  end


end
