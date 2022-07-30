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
require 'test_helper'

class RoutePlaceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
