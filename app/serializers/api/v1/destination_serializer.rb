class Api::V1::DestinationSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
  has_one :tour
end
