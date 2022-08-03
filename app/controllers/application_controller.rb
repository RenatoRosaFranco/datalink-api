# frozen_string_literal: true

class ApplicationController < ActionController::Base
	skip_before_action :verify_authenticity_token

	rescue_from ActiveRecord::RecordNotFound do |e|
		render json: { message: e.message }, status: :not_found
	end
end
