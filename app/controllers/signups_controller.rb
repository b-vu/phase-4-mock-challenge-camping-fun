class SignupsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def create
        Signup.create!(signup_params)
        render json: Activity.find(params[:activity_id]), status: :created
    end

    private
    
    def signup_params
        params.permit(:time, :activity_id, :camper_id)
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end
