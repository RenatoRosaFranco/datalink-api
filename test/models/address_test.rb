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
require 'test_helper'

class AddressTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
