require 'rails_helper'

RSpec.describe Api::V1::Price, type: :model do

    describe "Associations" do
      it { should belong_to(:tour) }
    end

    describe "Validations" do
      it { should validate_presence_of(:amount) }
      it { should validate_presence_of(:currency) }
      it { should validate_numericality_of(:amount).is_greater_than(0) }
    end
end
