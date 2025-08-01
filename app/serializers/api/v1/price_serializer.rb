class Api::V1::PriceSerializer < ActiveModel::Serializer
  attributes :id, :amount, :currency
  has_one :tour
end
