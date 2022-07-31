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
class Gallery < ApplicationRecord
  # Properties
  self.table_name  = 'galleries'
  self.primary_key = 'id'

  # FileUpload
  has_one_attached :image_path

  # Relationships
  belongs_to :place

  # Validations
  validates :image_path, attached: true,
                         content_type: [:png, :jpeg]
end
