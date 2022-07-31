# frozen_string_literal: true

module API
	module V1
		class AddressesController < ApplicationController
			before_action :set_address, only: [:show, :update, :destroy]

			def index
				addresses = Address.order(created_at: :desc)
													 .page(params[:page])
													 .per(params[:per_page])

				render json: { 
					addresses: addresses 
				}, status: :ok
			end

			def show
				render json: { 
					address: @address 
				}, status: :ok
			end

			def create
				address = Address.new(address_params)

				if address.save
					render json: { 
						address: address 
					}, status: :created
				else
					render json: { 
						errors: address.errors 
					}, status: :unprocessable_entity
				end
			end

			def update
				if @address.update_attributes(address_params)
					render json: { 
						address: @address 
					}, status: :accepted
				else
					render json: { 
						errors: @address.errors 
					}, status: :unprocessable_entity
				end
			end

			def destroy
				@address.destroy
				head :no_content
			end

			private

			def set_address
				@address = Address.find(params[:id])
			end

			def address_params
				params.require(:address)
					.permit(:location, :number, :place)
			end
		end
	end
end