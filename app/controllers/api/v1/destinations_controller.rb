class Api::V1::DestinationsController < ApplicationController
  before_action :set_api_v1_destination, only: %i[ show update destroy ]

  # GET /api/v1/destinations
  def index
    @api_v1_destinations = Api::V1::Destination.all

    render json: @api_v1_destinations
  end

  # GET /api/v1/destinations/1
  def show
    render json: @api_v1_destination
  end

  # POST /api/v1/destinations
  def create
    @api_v1_destination = Api::V1::Destination.new(api_v1_destination_params)

    if @api_v1_destination.save
      render json: @api_v1_destination, status: :created, location: @api_v1_destination
    else
      render json: @api_v1_destination.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/destinations/1
  def update
    if @api_v1_destination.update(api_v1_destination_params)
      render json: @api_v1_destination
    else
      render json: @api_v1_destination.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/destinations/1
  def destroy
    @api_v1_destination.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_destination
      @api_v1_destination = Api::V1::Destination.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_destination_params
      params.require(:api_v1_destination).permit(:name, :description, :tour_id)
    end
end
