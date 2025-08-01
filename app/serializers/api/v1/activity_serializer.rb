class Api::V1::ActivitySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_one :tour
end
