# frozen_string_literal: true

module API
	module V1
		class StatesController < ApplicationController
			before_action :set_state, only: [:show, :update, :destroy]

			def index
				states = State.order(:name)
											.page(params[:page])
											.per(params[:per_page])

				render json: { 
					states: states 
				}, status: :ok
			end

			def show
				render json: { 
					state: @state 
				}, status: :ok
			end

			def create
				state = State.new(state_params)

				if state.save
					render json: { 
						state: state 
					}, status: :created
				else
					render json: { 
						errors: state.errors 
					}, status: :unprocessable_entity
				end
			end

			def update
				if @state.update_attributes(state_params)
					render json: { 
						state: @state 
					}, status: :accepted
				else
					render json: { 
						errors: @state.errors 
					}, status: :unprocessable_entity
				end
			end

			def destroy
				@state.destroy
				head :no_content
			end

			private

			def set_state
				@state = State.find(params[:id])
			end

			def state_params
				params.require(:state)
					.permit(:name, :acronym, :region_id)
			end
		end
	end
end