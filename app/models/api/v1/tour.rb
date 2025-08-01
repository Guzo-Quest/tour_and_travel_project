class Api::V1::Tour < ApplicationRecord
  belongs_to :category
  belongs_to :admin
  has_many :tour_dates , dependent: :destroy
  has_many :prices , dependent: :destroy
  has_many :destinations , dependent: :destroy
  has_many :activities , dependent: :destroy
  accepts_nested_attributes_for :tour_dates, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :prices, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :destinations, allow_destroy: true, reject_if: :all_blank
  accepts_nested_attributes_for :activities, allow_destroy: true,  reject_if: :all_blank
  validates :name, :description, :duration, presence: true
  validates :name, uniqueness: true
  validates :duration, numericality: { only_integer: true, greater_than: 0 }
  has_many :bookings, dependent: :destroy
  has_many :users, through: :bookings
  has_many :reviews, class_name: 'Api::V1::Review', dependent: :destroy

end
