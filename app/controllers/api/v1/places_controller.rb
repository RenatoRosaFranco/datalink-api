# frozen_string_literal: true

module API
	module V1
		class PlacesController < ApplicationController
			before_action :set_place, only: [:show]

			def index
				places = Place.order(:name)
											.page(params[:page])
											.per(params[:per_page])

				render json: { 
					places: places 
				}, status: :ok
			end

			def show
				render json: { 
					place: @place 
				}, status: :ok
			end

			def create
				place = Place.new(place_params)

				if place.save
					render json: { 
						place: place 
					}, status: :created
				else
					render json: { 
						errors: place.errors 
					}, status: :unprocessable_entity
				end
			end

			def update
				if @place.update_attributes(place_params)
					render json: { 
						place: @place 
					}, status: :accepted
				else
					render json: { 
						errors: @place.errors 
					}, status: :unprocessable_entity
				end
			end

			def destroy
				@place.destroy
				head :no_content
			end

			private

			def set_place
				@place = Place.find(params[:id])
			end

			def place_params
				params.require(:place)
					.permit(:name, :kind, :state_id, :city_id)
			end
		end
	end
end