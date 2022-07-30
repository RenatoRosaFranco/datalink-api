# frozen_string_literal: true

module API
	module V1
		class PlacesController < ApplicationController
			before_action :set_place, only: [:show]

			def index
				places = Places.order(:name)
											 .page(params[:page])
											 .per(params[:per_page])

				render json: { places: places }, status: :ok
			end

			def show
				render json: { place: @place }, status: :ok
			end
		end
	end
end