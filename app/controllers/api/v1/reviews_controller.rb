class Api::V1::ReviewsController < ApplicationController
  before_action :set_api_v1_review, only: %i[ show update destroy ]
  before_action :authenticate_api_v1_user!, only: %i[ create update destroy ]

  # GET /api/v1/tours/:tour_id/reviews
  def index
    @api_v1_reviews = Api::V1::Review.where(tour_id: params[:tour_id])

    render json: @api_v1_reviews
  end

  # GET /api/v1/tours/:tour_id/reviews/:id
  def show
    render json: @api_v1_review
  end

  # POST /api/v1/tours/:tour_id/reviews
  def create
    # the user can only review the tour if he has booked the tour
    # @booking = current_api_v1_user.bookings.find_by(tour_id: params[:tour_id])

    # if @booking.nil?
    #   render json: { error: "You can only review the tour if you have booked the tour" }, status: :unprocessable_entity
    #   return
    # end

    @tour = Api::V1::Tour.find(params[:tour_id])
    @review = @tour.reviews.build(api_v1_review_params)
    @review.user = current_api_v1_user


    if @review.save
      render json: @review, status: :created, location: @api_v1_review
    else
      render json: @review.errors, status: :unprocessable_entity
    end

  end

  # PATCH/PUT /api/v1/tours/:tour_id/reviews/:id
  def update
    if @api_v1_review.update(api_v1_review_params)
      render json: @api_v1_review
    else
      render json: @api_v1_review.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/tours/:tour_id/reviews/:id
  def destroy
    @api_v1_review.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_review
      @api_v1_review = Api::V1::Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_review_params
      params.require(:api_v1_review).permit(:tour_id, :user_id, :rating, :review_text)
    end
end
