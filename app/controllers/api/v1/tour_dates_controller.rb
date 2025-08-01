class Api::V1::TourDatesController < ApplicationController
  before_action :set_api_v1_tour_date, only: %i[ show update destroy ]

  # GET /api/v1/tour_dates
  def index
    @api_v1_tour_dates = Api::V1::TourDate.all

    render json: @api_v1_tour_dates
  end

  # GET /api/v1/tour_dates/1
  def show
    render json: @api_v1_tour_date
  end

  # POST /api/v1/tour_dates
  def create
    @api_v1_tour_date = Api::V1::TourDate.new(api_v1_tour_date_params)

    if @api_v1_tour_date.save
      render json: @api_v1_tour_date, status: :created, location: @api_v1_tour_date
    else
      render json: @api_v1_tour_date.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/tour_dates/1
  def update
    if @api_v1_tour_date.update(api_v1_tour_date_params)
      render json: @api_v1_tour_date
    else
      render json: @api_v1_tour_date.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/tour_dates/1
  def destroy
    @api_v1_tour_date.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_tour_date
      @api_v1_tour_date = Api::V1::TourDate.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_tour_date_params
      params.require(:api_v1_tour_date).permit(:start_date, :end_date, :tour_id)
    end
end
