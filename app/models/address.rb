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
#  place_id   :integer
#
# Indexes
#
#  index_addresses_on_place_id  (place_id)
#
class Address < ApplicationRecord
  # Properties
  self.table_name  = 'addresses'
  self.primary_key = 'id'

  # Relationships
  belongs_to :place

  # Validations
  validates :location,
            presence: true,
            uniqueness: false,
            allow_blank: false,
            length: {
              minimum: 3,
              maximum: 50
            }

  validates :number,
            presence: true
end


