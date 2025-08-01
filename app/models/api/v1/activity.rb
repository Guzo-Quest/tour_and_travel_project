class Api::V1::Activity < ApplicationRecord
  belongs_to :tour
  validates :name, presence: true
end
