# == Schema Information
#
# Table name: routes
#
#  id         :integer          not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Route < ApplicationRecord
	extend FriendlyId
	friendly_id :name, use: [:slugged]

	# Properties
	self.table_name  = 'routes'
	self.primary_key = 'id'

	# Relationships
	has_many :route_places
	has_many :places, through: :route_places

	# Validations
	validates_uniqueness_of :name
	validates_presence_of :name
end
