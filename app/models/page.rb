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
class Page < ApplicationRecord
  # Properties
  self.table_name  = 'pages'
  self.primary_key = 'id'

  # Validations
  validates :vpath,
            length: {
              minimum: 3,
              maximum: 145
            }

  validates :about,
            length: {
              minimum: 3,
              maximum: 500
            }

  validates :facebook,
            length: {
              minimum: 3,
              maximum: 145
            }

  validates :instagram,
            length: {
              minimum: 3,
              maximum: 145
            }

  # Relationships
  belongs_to :place
end
