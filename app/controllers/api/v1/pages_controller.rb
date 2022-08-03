# frozen_string_literal: true

module API
	module V1
		class PagesController < ApplicationController
			before_action :set_page, only: [:show, :update, :destroy]
		
			def index
				pages = Page.order(created_at: :desc)
										.page(params[:page])
										.per(params[:per_page])

				render json: { 
					pages: pages 
				}, status: :ok
			end

			def show
				render json: { 
					page: @page 
				}, status: :ok
			end

			def create
				page = Page.new(page_params)

				if page.save
					render json: { 
						page: page 
					}, status: :created
				else
					render json: { 
						errors: page.errors 
					}, status: :unprocessable_entity
				end
			end

			def update
				if @page.update_attributes(page_params)
					render json: { 
						page: @page 
					}, status: :accepted
				else
					render json: { 
						errors: @page.errors 
					}, status: :unprocessable_entity
				end
			end

			def destroy
				@page.destroy
				head :no_content
			end

			private

			def set_page
				@page = Page.find(params[:id])
			end

			def page_params
				params.require(:page)
					.permit(:vpath, :about, :facebook, :instagram, :place_id)
			end
		end
	end
end