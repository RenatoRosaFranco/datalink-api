# frozen_string_literal: true

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
FactoryBot.define do
  factory :route_place do
    association :route, factory: :route
    association :place, factory: :place
  end
end
