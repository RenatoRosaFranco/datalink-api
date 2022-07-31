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
	# Properties
	self.table_name  = 'regions'
	self.primary_key = 'id'

	# Relationships
	has_many :states, dependent: :destroy

	# Validates
	validates :name,
						presence: true,
						uniqueness: true,
						allow_blank: false,
						length: {
							minimum: 2,
							maximum: 18
						}
end
