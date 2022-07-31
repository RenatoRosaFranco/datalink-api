# frozen_string_literal: true

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
FactoryBot.define do
  factory :page do
    vpath { FFaker::Youtube.embed_url }
    about { FFaker::LoremBR.paragraphs(1) }
    facebook { FFaker::Internet.http_url }
    instagram { FFaker::Internet.http_url }
    
    association :place, factory: :place, strategy: :build
  end
end
