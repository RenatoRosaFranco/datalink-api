# frozen_string_literal: true

# == Schema Information
#
# Table name: routes
#
#  id         :integer          not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :route do
    name { FFaker::AddressBR.neighborhood }
  end
end
