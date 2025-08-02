class Api::V1::CancellationSerializer < ActiveModel::Serializer
  attributes :id, :reason
  has_one :booking
end
