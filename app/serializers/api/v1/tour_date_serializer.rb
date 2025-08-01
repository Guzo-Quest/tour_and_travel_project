class Api::V1::TourDateSerializer < ActiveModel::Serializer
  attributes :id, :start_date, :end_date
  has_one :tour
end
