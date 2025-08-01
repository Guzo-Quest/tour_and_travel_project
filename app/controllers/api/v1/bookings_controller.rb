class Api::V1::BookingsController < ApplicationController
  before_action :set_api_v1_booking, only: %i[ show update destroy ]
  before_action :authenticate_api_v1_user!, only: %i[ create show cancel ]
  before_action :authenticate_api_v1_admin!, only: %i[ index update destroy ]

  # GET /api/v1/bookings
  def index
    @api_v1_bookings = Api::V1::Booking.all

    render json: @api_v1_bookings
  end

  # GET /api/v1/bookings/1
  def show
    render json: @api_v1_booking
  end

  # POST /api/v1/bookings
  def create
  # Check if the user has a profile
  if api_v1_booking_params[:profile_attributes].present?
    # Handle profile creation/update
    if current_api_v1_user.profile.nil?
      current_api_v1_user.create_profile(api_v1_booking_params[:profile_attributes])
    else
      current_api_v1_user.profile.assign_attributes(api_v1_booking_params[:profile_attributes])

      unless current_api_v1_user.profile.valid?
        render json: current_api_v1_user.profile.errors, status: :unprocessable_entity
        return
      end

      if current_api_v1_user.profile.changed?
        #update the profile
        current_api_v1_user.profile.save
        render json: current_api_v1_user.profile, status: :ok
        return
      end
    end
  elsif current_api_v1_user.profile.nil?
    # If profile is not provided, return error
    render json: { error: "You need to create a profile before booking" }, status: :unprocessable_entity
    return
  end

  # Check if the user has already booked the tour
  existing_booking = current_api_v1_user.bookings.find_by(tour_id: api_v1_booking_params[:tour_id])
  if existing_booking
    render json: { error: "You have already booked this tour" }, status: :unprocessable_entity
    return
  end

  # Proceed with creating the booking
  @api_v1_booking = current_api_v1_user.bookings.new(api_v1_booking_params.except(:profile_attributes))

  if @api_v1_booking.save
    render json: @api_v1_booking, status: :created, location: @booking
  else
    render json: @api_v1_booking.errors, status: :unprocessable_entity
  end
end



  # PATCH/PUT /api/v1/bookings/1
  def update
    if @api_v1_booking.update(api_v1_booking_params)
      render json: @api_v1_booking
    else
      render json: @api_v1_booking.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/bookings/1
  def destroy
    @api_v1_booking.destroy!
  end

  def cancel
    @api_v1_booking = Api::V1::Booking.find(params[:id])

    if @api_v1_booking.cancelled?
      render json: {error: "This booking is already cancelled"}, status: :unprocessable_entity
      return
    end

    # check if the booking is pending
    if @api_v1_booking.pending?
      @api_v1_booking.create_cancellation(reason: cancellation_params[:reason]) # create a cancellation record
      @api_v1_booking.cancelled! # change the status to cancelled
      render json: @api_v1_booking, status: :ok
      return
    end
    # check if the booking is confirmed
    if @api_v1_booking.confirmed?
      @api_v1_booking.create_cancellation(reason: cancellation_params[:reason]) # create a cancellation record
      @api_v1_booking.cancelled!
      render json: @api_v1_booking, status: :ok
      return
    end


  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_booking
      @api_v1_booking = Api::V1::Booking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_booking_params
      params.require(:api_v1_booking).permit(:user_id, :tour_id, :booking_status, profile_attributes: [:first_name, :last_name, :phone_number, :passport])
    end

    def cancellation_params
      params.require(:cancellation).permit(:reason)
    end

end
