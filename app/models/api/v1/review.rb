class Api::V1::Review < ApplicationRecord
  belongs_to :tour, class_name: 'Api::V1::Tour'
  belongs_to :user

  validates :tour_id, :user_id, :rating, :review_text, presence: true
  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 5 }
  validates :user_id, uniqueness: { scope: :tour_id, message: "You have already reviewed this tour" }
  validates :review_text, length: { minimum: 10, maximum: 500 }
  validates :tour_id, uniqueness: { scope: :user_id, message: "You have already reviewed this tour" }

  # validate :user_can_review?
  validate :user_must_have_booked_the_tour
  validate :user_can_review?, on: :create # validate user can only review the tour if he has booked the tour and it is completed

  private

  def self.average_rating(tour_id)
    where(tour_id: tour_id).average(:rating)
  end

  def self.reviews_count(tour_id)
    where(tour_id: tour_id).count
  end

  def self.reviews_by_user(user_id)
    where(user_id: user_id)
  end

  def self.reviews_by_tour(tour_id)
    where(tour_id: tour_id)
  end

  def self.reviews_by_user_and_tour(user_id, tour_id)
    where(user_id: user_id, tour_id: tour_id)
  end

  def user_can_review?
    booking = user&.bookings&.find_by(tour_id: tour_id)
    if !booking&.completed?
      errors.add(:error, "You can only review the tour if you have booked the tour and it is completed.")
    end
  end

  # custom validation
  def user_must_have_booked_the_tour
    booking = user&.bookings&.find_by(tour_id: tour_id)
    if booking.nil?
      errors.add(:error, "You need to book the tour before reviewing.")
    end
  end


end
