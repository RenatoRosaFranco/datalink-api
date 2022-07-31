# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  capital    :boolean
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state_id   :integer
#
# Indexes
#
#  index_cities_on_state_id  (state_id)
#
class City < ApplicationRecord
  # Properties
  self.table_name  = 'cities'
  self.primary_key = 'id'

  # Relationships
  has_many :addresses, dependent: :destroy
  belongs_to :state

  # Validations
  validates_uniqueness_of :name, scope: [:state_id]

  validates :name,
            presence: true,
            allow_blank: false,
            length: {
              minimum: 2,
              maximum: 45
            }

  validates :capital,
            presence: true,
            allow_blank: false,
            inclusion: [ true, false ]
end
