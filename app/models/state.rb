# frozen_string_literal: true

# == Schema Information
#
# Table name: states
#
#  id         :integer          not null, primary key
#  acronym    :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  region_id  :integer
#
# Indexes
#
#  index_states_on_region_id  (region_id)
#
class State < ApplicationRecord
  # Properties
  self.table_name  = 'states'
  self.primary_key = 'id'

  # Relationhips
  has_many :addresses, dependent: :destroy
  has_many :cities, dependent: :destroy
  belongs_to :region

  # Validations
  validates :name,
            presence: true,
            uniqueness: true,
            allow_blank: false,
            length: { 
              minimum: 3,
              maximum: 30
            }

  validates :acronym,
            presence: true,
            uniqueness: true,
            allow_blank: false,
            length: {
              minimum: 1,
              maximum: 5
            }
end
