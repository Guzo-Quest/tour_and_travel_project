class Api::V1::Price < ApplicationRecord
  belongs_to :tour
  validates :amount, :currency, presence: true
  validates :amount, numericality: { greater_than: 0 }

end
