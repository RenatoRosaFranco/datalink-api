# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  location   :string
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :integer
#  place_id   :integer
#  state_id   :integer
#
# Indexes
#
#  index_addresses_on_city_id   (city_id)
#  index_addresses_on_place_id  (place_id)
#  index_addresses_on_state_id  (state_id)
#
class Address < ApplicationRecord
  # Properties
  self.table_name  = 'addresses'
  self.primary_key = 'id'

  # Relationships
  belongs_to :place
  belongs_to :state, optional: true
  belongs_to :city,  optional: true

  # Validations
  validates_uniqueness_of :location, scope: [:place_id]

  validates :location,
            presence: true,
            allow_blank: false,
            length: {
              minimum: 3,
              maximum: 50
            }

  validates :number,
            presence: true,
            numericality: {
              only_integer: true,
              greater_than_or_equal_to: 1,
              less_than_or_equal_to: 5_000
            }
end


