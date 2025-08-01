class Api::V1::Booking < ApplicationRecord
  enum booking_status: { pending: 'pending', confirmed: 'confirmed', cancelled: 'cancelled' , completed: 'completed' }
  belongs_to :user
  belongs_to :tour
  validates :tour_id, :user_id, :booking_status, presence: true
  scope :by_user, ->(user) { where(user: user) }
  has_one :profile, through: :user
  # validates :user_id, uniqueness: { scope: :tour_id, message: "You have already booked this tour" }
  has_one :cancellation, class_name: 'Api::V1::Cancellation', dependent: :destroy
end
