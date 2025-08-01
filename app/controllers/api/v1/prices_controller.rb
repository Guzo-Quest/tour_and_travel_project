class Api::V1::PricesController < ApplicationController
  before_action :set_api_v1_price, only: %i[ show update destroy ]

  # GET /api/v1/prices
  def index
    @api_v1_prices = Api::V1::Price.all

    render json: @api_v1_prices
  end

  # GET /api/v1/prices/1
  def show
    render json: @api_v1_price
  end

  # POST /api/v1/prices
  def create
    @api_v1_price = Api::V1::Price.new(api_v1_price_params)

    if @api_v1_price.save
      render json: @api_v1_price, status: :created, location: @api_v1_price
    else
      render json: @api_v1_price.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/prices/1
  def update
    if @api_v1_price.update(api_v1_price_params)
      render json: @api_v1_price
    else
      render json: @api_v1_price.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/prices/1
  def destroy
    @api_v1_price.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_price
      @api_v1_price = Api::V1::Price.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_price_params
      params.require(:api_v1_price).permit(:amount, :currency, :tour_id)
    end
end
