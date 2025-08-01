class Api::V1::TourDate < ApplicationRecord
  belongs_to :tour
  validates :start_date, :end_date, presence: true

  validate :start_date_cannot_be_in_the_past
  validate :end_date_cannot_be_in_the_past
  validate :end_date_cannot_be_before_start_date

  def self.by_tour(tour) # to get all tour dates by tour
    where(tour: tour)
  end

  #it will check if start date is not in the past
  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "can't be in the past")
    end
  end

  # this will check if end date is not in the past,
  def end_date_cannot_be_in_the_past
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, "can't be in the past")
    end
  end

  # this will check if end date is not before start date
  def end_date_cannot_be_before_start_date
    if start_date.present? && end_date.present? && end_date < start_date
      errors.add(:end_date, "can't be before the start date")
    end
  end

end
