# frozen_string_literal: true

module API
	module V1
		class RoutePlacesController < ApplicationController
			before_action :set_route_place, only: [:show, :edit, :update, :destroy]

			def index
				route_places = RoutePlace.order(created_at: :desc)
																 .page(params[:page])
																 .per(params[:per_page])
				
				render json: { 
					route_places: route_places 
				}, status: :ok
			end

			def show
				render json: { 
					route_place: @route_place 
				}, status: :ok
			end

			def create
				route_place = RoutePlace.new(route_place_params)

				if route_place.save
					render json: {
						route_place: route_place
					}, status: :created
				else
					render json: { 
						errors: route_place.errors
					}, status: :unprocessable_entity
				end
			end

			def update
				if @route_place.update_attributes(route_place_params)
					render json: { 
						route_place: @route_place 
					}, status: :accepted
				else
					render json: { 
						errors: @route_place.errors 
					}, status: :unprocessable_entity
				end
			end

			def destroy
				@route_place.destroy
				head :no_content
			end

			private

			def set_route_place
				@route_place = RoutePlace.find(params[:id])
			end

			def route_place_params
				params.require(:route_place).permit(:route_id, :place_id)
			end
		end
	end
end