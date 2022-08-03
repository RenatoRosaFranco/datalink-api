# frozen_string_literal: true

module API
	module V1
		class CitiesController < ApplicationController
			before_action :set_city, only: [:show, :update, :destroy]

			def index
				cities = City.order(created_at: :desc)
										 .page(params[:page])
										 .per(params[:per_page])

				render json: { 
					cities: cities 
				}, status: :ok
			end

			def show
				render json: { 
					city: @city 
				}, status: :ok
			end

			def create
				city = City.new(city_params)

				if city.save
					render json: { 
						city: city 
					}, status: :created
				else
					render json: { 
						errors: city.errors 
					}, status: :unprocessable_entity
				end
			end

			def update
				if @city.update_attributes(city_params)
					render json: { 
						city: @city 
					}, status: :accepted
				else
					render json: { 
						errors: @city.errors 
					}, status: :unprocessable_entity
				end
			end

			def destroy
				@city.destroy
				head :no_content
			end

			private

			def set_city
				@city = City.find(params[:id])
			end

			def city_params
				params.require(:city).permit(:name, :capital, :state_id)
			end
		end
	end
end