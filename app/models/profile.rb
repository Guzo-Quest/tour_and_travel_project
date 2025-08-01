class Profile < ApplicationRecord
  belongs_to :user
  validates :first_name, :last_name, :phone_number, :passport, presence: true
  validates :phone_number, length: { in: 10..13 }, uniqueness: true
  validates :user_id, uniqueness: true # makes sure that a user can only have one profile
end
