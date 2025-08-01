class Api::V1::Destination < ApplicationRecord
  belongs_to :tour
  validates :name, presence: true
end
