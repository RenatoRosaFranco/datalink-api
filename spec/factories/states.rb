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
FactoryBot.define do
  factory :state do
    name { FFaker::AddressBR.state }
    acronym { FFaker::AddressBR.state_abbr }
    
    association :region, factory: :region, strategy: :build
  end
end
