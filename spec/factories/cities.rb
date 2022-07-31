# frozen_string_literal: true

# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  capital    :boolean
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state_id   :integer
#
# Indexes
#
#  index_cities_on_state_id  (state_id)
#
FactoryBot.define do
  factory :city do
    name { FFaker::AddressBR.city }
    capital { true }
    
    association :state, factory: :state, strategy: :build
  end
end
