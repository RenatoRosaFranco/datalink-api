# frozen_string_literal: true

# == Schema Information
#
# Table name: route_places
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  place_id   :integer
#  route_id   :integer
#
# Indexes
#
#  index_route_places_on_place_id  (place_id)
#  index_route_places_on_route_id  (route_id)
#
require 'rails_helper'

RSpec.describe RoutePlace, type: :model do
  subject { FactoryBot.build(:route_place, route: route, place: place) }
  let(:route) { FactoryBot.create(:route, name: 'Turismo I') }
  let(:place) { FactoryBot.create(:place, name: 'Praça da Lagoa', kind: 'Tourist Spot') }

  context 'Attributes', :aggregate_failures do
    it 'should respond to all attributes' do
      expect(subject).to respond_to(:route_id)
      expect(subject).to respond_to(:place_id)
    end
  end

  context 'Relationships', :aggregate_failures do
    it { is_expected.to belong_to(:route) }
    it { is_expected.to belong_to(:place) }
  end

  context 'Validations' do
    it { is_expected.to validate_uniqueness_of(:place_id).scoped_to(:route_id) }
  end
end
