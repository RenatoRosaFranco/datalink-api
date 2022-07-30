# frozen_string_literal: true

# == Schema Information
#
# Table name: places
#
#  id         :integer          not null, primary key
#  kind       :integer
#  name       :string
#  short_link :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :integer
#  state_id   :integer
#
# Indexes
#
#  index_places_on_city_id   (city_id)
#  index_places_on_state_id  (state_id)
#
require 'rqrcode'

class Place < ApplicationRecord
	extend FriendlyId
	friendly_id :name, use: [:slugged]

	# Properties
	self.table_name = 'places'
	self.primary_key = 'id'

	# Enum
	enum kind: [
		'Company',
		'Tourist Spot',
		'Public Place'
	]

	# Relationhips
	has_one :page, dependent: :destroy
	has_one :address, dependent: :destroy

	has_many :route_places
	has_many :routes, through: :route_places
	has_many :photos, dependent: :destroy

	belongs_to :state
	belongs_to :city
	
	# Validations
	validates_presence_of :name
	validates_uniqueness_of :name

	validates_uniqueness_of :short_link
	validates_presence_of :short_link
	
	validates_presence_of :kind

	# Callbacks
	before_create :generate_short_link
	before_create :generate_qrcode
	after_create  :create_page
	after_create  :create_address
 	
 	# Generate place short link
	def generate_short_link
		self.short_link = SecureRandom.urlsafe_base64(15)
	end

	# Generate place QRcode
	def generate_qrcode
		qrcode = RQRCode::QRCode.new(self.short_link)
		svg = qrcode.as_svg(
			color: "000",
			shape_rendering: "crispEdges",
			module_size: 11,
			standalone: true,
			use_path: true
		)
	end
end
