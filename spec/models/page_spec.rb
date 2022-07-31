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
require 'rails_helper'

RSpec.describe Page, type: :model do
  let!(:place) { FactoryBot.create(:place, kind: 'Praça XV', kind: 'Tourist Spot') }
  subject { FactoryBot.create(:page, place: place) }

  context 'Attributes' do
    it 'shold respond to all attributes', :aggregate_failures do
      expect(subject).to respond_to(:vpath)
      expect(subject).to respond_to(:about)
      expect(subject).to respond_to(:facebook)
      expect(subject).to respond_to(:instagram)
      expect(subject).to respond_to(:place_id)
    end
  end

  context 'Associations' do
    it { is_expected.to belong_to(:place) }
  end

  context 'Validations' do
    context '.vpath', :aggregate_failures do
      it { is_expected.to validate_length_of(:vpath).is_at_least(3) }
      it { is_expected.to validate_length_of(:vpath).is_at_most(145) }
    end

    context '.about', :aggregate_failures do
      it { is_expected.to validate_length_of(:about).is_at_least(3) }
      it { is_expected.to validate_length_of(:about).is_at_most(500) }
    end

    context '.facebook', :aggregate_failures do
      it { is_expected.to validate_length_of(:facebook).is_at_least(3) }
      it { is_expected.to validate_length_of(:facebook).is_at_most(145) }
    end

    context '.instagram', :aggregate_failures do
      it { is_expected.to validate_length_of(:instagram).is_at_least(3) }
      it { is_expected.to validate_length_of(:instagram).is_at_most(145) }
    end
  end
end
