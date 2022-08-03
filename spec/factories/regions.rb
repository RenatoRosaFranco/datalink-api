# frozen_string_literal: true

# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :region do
    name { FFaker::Name.unique.first_name }
  end
end
