# == Schema Information
#
# Table name: route_places
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  place_id   :integer
#  route_id   :integer
#
# Indexes
#
#  index_route_places_on_place_id  (place_id)
#  index_route_places_on_route_id  (route_id)
#
class RoutePlace < ApplicationRecord
  # Properties
  self.table_name  = 'route_places'
  self.primary_key = 'id'

  # Relationships
  belongs_to :route
  belongs_to :place

  # Validations
  validates_uniqueness_of :place_id, 
                          sscope: [:route_id]
end
