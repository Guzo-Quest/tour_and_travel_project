class Api::V1::Category < ApplicationRecord
  has_many :tours
  validates :name, presence: true
  validates :name, uniqueness: true
end
