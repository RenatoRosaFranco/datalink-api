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
#
require 'rqrcode'

class Place < ApplicationRecord
	extend FriendlyId
	friendly_id :name, use: [:slugged]

	# Properties
	self.table_name  = 'places'
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
	has_many :photos, class_name: 'Gallery', dependent: :destroy
	
	# Validations
	validates :name,
						presence: true,
						uniqueness: true,
						allow_blank: false,
						length: { 
							minimum: 3,
							maximum: 30
						}

	validates :kind,
						presence: true,
						uniqueness: false,
						allow_blank: false,
						inclusion: { in: Place.kinds.keys }

	validates :short_link,
						presence: true,
						uniqueness: true,
						allow_blank: false

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
