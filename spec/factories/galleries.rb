# frozen_string_literal: true

# == Schema Information
#
# Table name: galleries
#
#  id         :integer          not null, primary key
#  image_path :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  place_id   :integer
#
# Indexes
#
#  index_photos_on_place_id  (place_id)
#
FactoryBot.define do
  factory :gallery do
    image_path { File.open(Rails.root.join('spec', 'files', 'image.jpg').to_s) }

    association :place, factory: :place, strategy: :build
  end
end
