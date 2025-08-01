class Api::V1::ProfilesController < ApplicationController
  # before_action :set_profile, only: %i[ show update destroy ]
  before_action :authenticate_api_v1_user!, only: %i[ show create update destroy ]
  before_action :authenticate_api_v1_admin!, only: %i[ index ]
  # GET /api/v1/profiles
  def index
    @profiles = Profile.all

    render json: @profiles
  end

  # GET /api/v1/profiles/
  def show
    @profile = current_api_v1_user.profile
    if @profile
      render json: @profile
    else
      render json: { success: false , message: 'Profile not found' }, status: :not_found
    end
    #render json: @profile, location: api_v1_profile_url(@profile)
  end

  # POST /api/v1/profiles/
  def create
    @profile = Profile.new(profile_params)
    @profile.user = current_api_v1_user

    if @profile.save
      render json: @profile, status: :created, location: api_v1_profile_url(@profile)
    else
      render json: @profile.errors, status: :unprocessable_entity
    end
  end


  # PATCH/PUT /api/v1/profile
  def update
    @profile = current_api_v1_user.profile
    if @profile
      if @profile.update(profile_params)
        render json: @profile
      else
        render json: @profile.errors, status: :unprocessable_entity
      end
    else
      render json: { success: false , message: 'Profile not found' }, status: :not_found
    end
  end

  # DELETE /api/v1/profiles
  def destroy
    @profile = current_api_v1_user.profile
    if @profile
      @profile.destroy!
      render json: { success: true, message: 'Profile deleted successfully' }
    else
      render json: { success: false , message: 'Profile not found'}, status: :not_found

    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def profile_params
      params.require(:profile).permit(:first_name, :last_name, :phone_number, :passport, :profile_picture)
    end

    # def profile_params
    #   params.require(:profile).permit(:first_name, :last_name, :phone_number, :passport, :profile_picture)
    # end

end
