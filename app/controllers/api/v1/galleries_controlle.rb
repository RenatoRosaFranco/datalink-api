# frozen_string_literal: true

module API
	module V1
		class GalleriesController < ApplicationController
			before_action :set_gallery, only: [:show, :update, :destroy]

			def index
				@galleries = Gallery.order(created_at: :desc)
														.page(params[:page])
														.per(params[:per_page])
				
				render json: {
					galleries: galleries
				}, status: :ok
			end

			def show
				rende json: {
					gallery: @gallery
				}, status: :ok
			end

			def create
				gallery = Gallery.new(gallery_params)

				if gallery.save
					render json: {
						gallery: gallery
					}, status: :created
				else
					render json: {
						errors: gallery.errors
					}, status: :unprocessable_entity
				end
			end

			def update
				if @gallery.update_attributes(gallery_params)
					render json: {
						gallery: @gallery
					}, status: :accepted
				else
					rende json: {
						errors: @gallery.errors
					}, status: :unprocessable_entity
				end
			end

			def destroy
				@gallery.destroy
			  head :no_content
			end

			private

			def set_gallery
				@gallery = Gallery.find(params[:id])
			end

			def set_gallery
				params.require(:gallery)
					.permit(:image_path, :place_id)
			end
		end
	end
end