require 'rails_helper'

RSpec.describe Api::V1::Category, type: :model do
  describe "Associations" do
    it { should have_many(:tours) }
  end

  describe "Validations" do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
  end
end
