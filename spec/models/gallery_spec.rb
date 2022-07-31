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
require 'rails_helper'

RSpec.describe Gallery, type: :model do
  let(:place) { FactoryBot.build(:place, name: 'Mecautor', kind: 'Company') }

  subject {
    Gallery.new(
      image_path: File.open(Rails.root.join('spec', 'files', 'image.jpg').to_s),
      place: place
    )
  }

  context 'Attributes' do
    it 'should respond to all attributes', :aggregate_failures do
      expect(subject).to respond_to(:image_path)
      expect(subject).to respond_to(:place)
    end
  end

  context 'Associations' do
    it { is_expected.to belong_to :place }
  end

  context 'Validations' do
    context '.photo', :aggregate_failures do
      it { is_expected.to validate_attached_of(:image_path) }
      it { is_expected.to validate_content_type_of(:image_path).allowing('image/png', 'image/jpeg') }
      it { is_expected.to validate_content_type_of(:image_path).rejecting('image/gif', 'image/bmp') }
    end
  end
end
