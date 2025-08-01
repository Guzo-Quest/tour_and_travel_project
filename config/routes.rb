Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # resources :reviews
      resources :cancellations
      resources :bookings do
        #create route for cancel action like this: patch /api/v1/bookings/:id/cancel
        patch :cancel, on: :member
      end
      resources :activities
      resources :destinations
      resources :prices
      resources :tour_dates
      resources :tours do
        resources :reviews, only: [:index, :create, :show, :update, :destroy]
        # GET /api/v1/tours/:tour_id/reviews,
        # POST /api/v1/tours/:tour_id/reviews
        # GET /api/v1/tours/:tour_id/reviews/:id
        # PATCH/PUT /api/v1/tours/:tour_id/reviews/:id
        # DELETE /api/v1/tours/:tour_id/reviews/:id
      end
      resources :categories
      #resource :profiles # it will create all the routes for profiles like index, show, create, update, destroy
      # the index route will be like this: /api/v1/profiles

      # get 'profiles', to: 'profiles#index'
      resources :profiles, only: [:index] # GET /api/v1/profiles
      resource :profile, only: [:show, :create, :update, :destroy] # GET, POST, PATCH/PUT, DELETE /api/v1/profile


      mount_devise_token_auth_for 'User', at: 'auth'

      mount_devise_token_auth_for 'Admin', at: 'Admin_auth'
      as :admin do
        # Define routes for Admin within this block.
      end
    end
  end
end
