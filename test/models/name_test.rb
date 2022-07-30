# == Schema Information
#
# Table name: names
#
#  id         :integer          not null, primary key
#  State      :string
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
require 'test_helper'

class NameTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
