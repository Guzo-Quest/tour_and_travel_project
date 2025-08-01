class Api::V1::TourSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :duration, :image, :average_rating, :reviews_count
  has_one :category
  # has_one :admin
  has_many :reviews, serializer: Api::V1::ReviewSerializer
  has_many :tour_dates, serializer: Api::V1::TourDateSerializer
  has_many :prices, serializer: Api::V1::PriceSerializer
  has_many :destinations, serializer: Api::V1::DestinationSerializer
  has_many :activities, serializer: Api::V1::ActivitySerializer
  # has_many :bookings, serializer: Api::V1::BookingSerializer
  # has_many :users, through: :bookings
  has_many :reviews, serializer: Api::V1::ReviewSerializer
  # add average_rating to the json response
  def average_rating
    Api::V1::Review.average_rating(object.id)
  end

  def reviews_count
    Api::V1::Review.reviews_count(object.id)
  end


end
