class Api::V1::ActivitiesController < ApplicationController
  before_action :set_api_v1_activity, only: %i[ show update destroy ]

  # GET /api/v1/activities
  def index
    @api_v1_activities = Api::V1::Activity.all

    render json: @api_v1_activities
  end

  # GET /api/v1/activities/1
  def show
    render json: @api_v1_activity
  end

  # POST /api/v1/activities
  def create
    @api_v1_activity = Api::V1::Activity.new(api_v1_activity_params)

    if @api_v1_activity.save
      render json: @api_v1_activity, status: :created, location: @api_v1_activity
    else
      render json: @api_v1_activity.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/activities/1
  def update
    if @api_v1_activity.update(api_v1_activity_params)
      render json: @api_v1_activity
    else
      render json: @api_v1_activity.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/activities/1
  def destroy
    @api_v1_activity.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_activity
      @api_v1_activity = Api::V1::Activity.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def api_v1_activity_params
      params.require(:api_v1_activity).permit(:name, :tour_id)
    end
end
