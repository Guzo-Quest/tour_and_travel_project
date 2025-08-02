require 'rails_helper'

RSpec.describe Api::V1::Cancellation, type: :model do
  describe 'associations' do
    it { should belong_to(:booking) }
  end
end
