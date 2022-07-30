# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Region < ApplicationRecord
	include BRPopulate

	# Properties
	self.table_name  = 'regions'
	self.primary_key = 'id'

	# Relationships
	has_many :states, dependent: :destroy

	# Methods
	def self.load_data
		BRPopulate.populate
	end
end
