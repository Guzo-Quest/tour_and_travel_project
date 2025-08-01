class Api::V1::BookingSerializer < ActiveModel::Serializer
  attributes :id, :booking_status
  has_one :user
  has_one :tour, serializer: Api::V1::TourSerializer
  has_one :profile
  has_one :cancellation, serializer: Api::V1::CancellationSerializer
end
