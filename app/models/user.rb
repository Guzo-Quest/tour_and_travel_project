# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable
  include DeviseTokenAuth::Concerns::User
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_one :profile, dependent: :destroy # if user is deleted, profile is deleted
  # after_create :create_profile  # creates a profile for a user after sign up
  has_many :bookings, class_name: 'Api::V1::Booking'
  has_many :tours, through: :bookings
  has_many :cancellations, through: :bookings
  has_many :reviews, dependent: :destroy, class_name: 'Api::V1::Review'
  # private

  # def create_profile
  #   Profile.create(user_id: id)
  # end
end
