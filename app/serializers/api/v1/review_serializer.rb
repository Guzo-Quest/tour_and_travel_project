class Api::V1::ReviewSerializer < ActiveModel::Serializer
  attributes :id, :rating, :review_text
  has_one :tour
  has_one :user
end
