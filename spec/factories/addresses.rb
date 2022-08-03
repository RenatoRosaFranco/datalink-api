# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  location   :string
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :integer
#  place_id   :integer
#  state_id   :integer
#
# Indexes
#
#  index_addresses_on_city_id   (city_id)
#  index_addresses_on_place_id  (place_id)
#  index_addresses_on_state_id  (state_id)
#
FactoryBot.define do
  factory :address do
    location { FFaker::AddressBR.unique.street }
    number { rand(1..5_000) }
    
    place
    state
    city
  end
end
