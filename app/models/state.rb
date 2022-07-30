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
#  index_names_on_region_id  (region_id)
#
class State < ApplicationRecord
  # Properties
  self.table_name  = 'states'
  self.primary_key = 'id'

  # Scope
  default_scope { where(name: 'Rio Grande do Sul') }

  # Relationhips
  has_many :places, dependent: :destroy

  # Relationships
  belongs_to :region
end
