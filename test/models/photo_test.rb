# == Schema Information
#
# Table name: photos
#
#  id         :integer          not null, primary key
#  image_path :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  place_id   :integer
#
# Indexes
#
#  index_photos_on_place_id  (place_id)
#
require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
