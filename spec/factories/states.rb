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
FactoryBot.define do
  factory :state do
    name { FFaker::Name.unique.name }
    acronym { FFaker::Name.unique.last_name[0..3] }
    
    region
  end
end
