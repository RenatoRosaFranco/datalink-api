# frozen_string_literal: true

module API
	module V1
		class RegionsController < ApplicationController
			before_action :set_region, only: [:show, :update, :destroy]

			def index
				regions = Region.order(created_at: :desc)
												.page(params[:page])
												.per(params[:per_page])

				render json: { 
					regions: regions 
				}, status: :ok
			end

			def show
				render json: { 
					region: @region 
				}
			end

			def create
				region = Region.new(region_params)

				if region.save
					render json: { 
						region: region 
					}, status: :created
				else
					render json: { 
						errors: region.errors 
					}, status: :unprocessable_entity
				end
			end

			def update
				if @region.update_attributes(region_params)
					render json: { 
						region: @region 
					}, status: :accepted
				else
					render json: { 
						errors: @region.errors 
					}, status: :unprocessable_entity
				end
			end

			def destroy
				@region.destroy
				head :no_content
			end

			private

			def set_region
				@region = Region.find(params[:id])
			end

			def region_params
				params.require(:region).permit(:name)
			end
		end
	end
end