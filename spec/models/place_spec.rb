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
require 'rails_helper'

RSpec.describe Place, type: :model do
  let!(:region) { FactoryBot.create(:region, name: 'Sul') }
  let(:state) { FactoryBot.create(:state, name: 'Rio Grande do Sul', acronym: 'RS', region: region) }
  let(:city) { FactoryBot.create(:city, name: 'São Borja', capital: false, state: state) }

  subject { FactoryBot.build(:place, name: 'Mecautor', kind: 'Company') }

  context 'Attributes' do
    it 'should respond to all attributes', :aggregate_failures do
      expect(subject).to respond_to(:name)
      expect(subject).to respond_to(:kind)
      expect(subject).to respond_to(:short_link)
      expect(subject).to respond_to(:slug)
    end
  end

  context 'Associations', :aggreate_failures do
    it { is_expected.to have_one(:page) }
    it { is_expected.to have_one(:address) }
    it { is_expected.to have_many(:route_places) }
    it { is_expected.to have_many(:routes) }
  end

  context 'Validations' do
    context '.name', :aggregate_failures do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_uniqueness_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_least(3) }
      it { is_expected.to validate_length_of(:name).is_at_most(30) }
    end

    context '.kind' do
      it { is_expected.to validate_presence_of(:kind) }
      it { is_expected.not_to validate_uniqueness_of(:kind) }
      it { is_expected.not_to allow_value(nil).for(:kind) }
    end

    context '.short_link' do
      it { is_expected.to validate_uniqueness_of(:short_link) }
    end
  end

  context 'Methods' do
    let(:place) { FactoryBot.build(:place, name: 'Mecautor', kind: 'Company') }

    context '.generate_short_link' do
      before do
        place.generate_short_link
        place.save
      end

      it 'should a short link be generated', :aggregate_failures do
        expect(place.short_link).to_not be_nil
      end
    end
  end
end
