# == Schema Information
#
# Table name: pages
#
#  id         :integer          not null, primary key
#  about      :text
#  facebook   :string
#  instagram  :string
#  vpath      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  place_id   :integer
#
# Indexes
#
#  index_pages_on_place_id  (place_id)
#
require 'test_helper'

class PageTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
