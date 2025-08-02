class Api::V1::CancellationsController < ApplicationController
  before_action :set_api_v1_cancellation, only: %i[ show update destroy ]

  # GET /api/v1/cancellations
  def index
    @api_v1_cancellations = Api::V1::Cancellation.all

    render json: @api_v1_cancellations
  end

  # GET /api/v1/cancellations/1
  def show
    render json: @api_v1_cancellation
  end

  # POST /api/v1/cancellations
  def create
    @api_v1_cancellation = Api::V1::Cancellation.new(api_v1_cancellation_params)

    if @api_v1_cancellation.save
      render json: @api_v1_cancellation, status: :created, location: @api_v1_cancellation
    else
      render json: @api_v1_cancellation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/cancellations/1
  def update
    if @api_v1_cancellation.update(api_v1_cancellation_params)
      render json: @api_v1_cancellation
    else
      render json: @api_v1_cancellation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/cancellations/1
  def destroy
    @api_v1_cancellation.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_cancellation
      @api_v1_cancellation = Api::V1::Cancellation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_cancellation_params
      params.require(:api_v1_cancellation).permit(:booking_id, :reason)
    end
end
