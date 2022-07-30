# frozen_string_literal: true

class PlacesController < HomeController
	before_action :set_place, only: [:show]

	def index
		@places = Place.order(created_at: :desc)
									 .page(params[:page])
									 .per(12)
	end

	def show
	end

	private

	def set_place
		@place = Place.find(params[:id])
	end
end