# frozen_string_literal: true

# == Schema Information
#
# Table name: addresses
#
#  id         :integer          not null, primary key
#  location   :string
#  number     :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  city_id    :integer
#  place_id   :integer
#  state_id   :integer
#
# Indexes
#
#  index_addresses_on_city_id   (city_id)
#  index_addresses_on_place_id  (place_id)
#  index_addresses_on_state_id  (state_id)
#
require 'rails_helper'

RSpec.describe Address, type: :model do
  subject(:address) { FactoryBot.create(:address, place: place) }
  let!(:place) { FactoryBot.create(:place) }
  
  context 'Attributes' do
    it 'should respond to all attributes', :aggregate_failures do
      expect(subject).to respond_to(:location)
      expect(subject).to respond_to(:number)
      expect(subject).to respond_to(:place_id)
    end
  end

  context 'Relationships' do
    it { is_expected.to belong_to(:place) }
    it { is_expected.to belong_to(:state).optional(true) }
    it { is_expected.to belong_to(:city).optional(true) }
  end

  context 'Validations' do
    context '.location', :aggregate_failures do
      it { is_expected.to validate_presence_of(:location ) }
      it { is_expected.to validate_uniqueness_of(:location).scoped_to(:place_id) }
      it { is_expected.to validate_length_of(:location).is_at_least(3) }
      it { is_expected.to validate_length_of(:location).is_at_most(50) }
    end

    context '.number', :aggregate_failures do
      it { is_expected.to validate_presence_of(:number) }
      it { is_expected.to validate_numericality_of(:number).only_integer }
    end
  end
end
