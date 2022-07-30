# == Schema Information
#
# Table name: places
#
#  id         :integer          not null, primary key
#  kind       :integer
#  name       :string
#  short_link :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :integer
#  state_id   :integer
#
# Indexes
#
#  index_places_on_city_id   (city_id)
#  index_places_on_state_id  (state_id)
#
require 'test_helper'

class PlaceTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
