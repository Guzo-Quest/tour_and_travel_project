class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :phone_number, :passport, :profile_picture
  has_one :user
end
