# frozen_string_literal: true

# == Schema Information
#
# Table name: places
#
#  id         :integer          not null, primary key
#  kind       :integer          default("Company")
#  name       :string
#  short_link :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :place do
    name { FFaker::Company.name[4..30] }
    kind { Place.kinds.keys.sample }
    short_link { SecureRandom.urlsafe_base64(15) }
  end
end
