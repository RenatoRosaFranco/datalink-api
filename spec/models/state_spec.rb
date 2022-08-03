# frozen_string_literal: true

# == Schema Information
#
# Table name: states
#
#  id         :integer          not null, primary key
#  acronym    :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  region_id  :integer
#
# Indexes
#
#  index_states_on_region_id  (region_id)
#
require 'rails_helper'

RSpec.describe State, type: :model do
  let(:region) { FactoryBot.create(:region, name: 'Sul') }
  subject { FactoryBot.build(:state, name: 'Rio Grande do Sul', acronym: 'RS', region: region) }

  context 'Attributes' do
    it 'should respond to all attributes', :aggregate_failures do
      expect(subject).to respond_to(:name)
      expect(subject).to respond_to(:acronym)
      expect(subject).to respond_to(:region_id)
    end
  end

  context 'Associations', :aggregate_failures do
    it { is_expected.to belong_to(:region) }
    it { is_expected.to have_many(:addresses) }
    it { is_expected.to have_many(:cities) }
  end

  context 'Validations' do
    context '.name', :aggregate_failures do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_uniqueness_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_least(3) }
      it { is_expected.to validate_length_of(:name).is_at_most(30) }
    end

    context '.acronym', :aggregate_failures do
      it { is_expected.to validate_presence_of(:acronym) }
      it { is_expected.to validate_uniqueness_of(:acronym) }
      it { is_expected.to validate_length_of(:acronym).is_at_least(1) }
      it { is_expected.to validate_length_of(:acronym).is_at_most(5) }
    end
  end
end
