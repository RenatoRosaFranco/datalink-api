# frozen_string_literal: true

module API
	module V1
		class RoutesController < ApplicationController
			before_action :set_route, only: [:show, :update, :destroy]

			def index
				routes = Route.order(created_at: :desc)
											.page(params[:page])
											.per(params[:per_page])

				render json: { 
					routes: routes 
				}, status: :ok
			end

			def show
				render json: { 
					route: @route 
				}, status: :ok
			end

			def create
				route = Route.new(route_params)

				if route.save
					render json: { 
						route: route 
					}, status: :created
				else
					render json: { 
						errors: route.errors 
					}, status: :unprocessable_entity
				end
			end

			def update
				if @route.update_attributes(route_params)
					render json: { 
						route: @route 
					}, status: :accepted
				else
					render json: { 
						errors: @route.errors 
					}, status: :unprocessable_entity
				end
			end

			def destroy
				@route.destroy
				head :no_content
			end

			private

			def set_route
				@route = Route.find(params[:id])
			end

			def route_params
				params.require(:route).permit(:name)
			end
		end
	end
end