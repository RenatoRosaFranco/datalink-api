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
    vpath { FFaker::Youtube.unique.embed_url }
    about { FFaker::LoremBR.unique.paragraphs(1) }
    facebook { FFaker::Internet.unique.http_url }
    instagram { FFaker::Internet.unique.http_url }
    
    place
  end
end
