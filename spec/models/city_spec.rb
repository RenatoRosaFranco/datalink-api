# frozen_string_literal: true

# == Schema Information
#
# Table name: cities
#
#  id         :integer          not null, primary key
#  capital    :boolean
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  state_id   :integer
#
# Indexes
#
#  index_cities_on_state_id  (state_id)
#
require 'rails_helper'

RSpec.describe City, type: :model do
  let!(:region) { FactoryBot.create(:region, name: 'São Borja') }
  let(:state) { FactoryBot.create(:state, name: 'Rio Grande do Sul', acronym: 'RS') }
  subject { FactoryBot.build(:city, name: 'São Borja', capital: false, state: state) }

  context 'Attributes' do
    it 'should respond to all attributes', :aggregate_failures do
      expect(subject).to respond_to(:name)
      expect(subject).to respond_to(:capital)
      expect(subject).to respond_to(:state_id)
    end
  end

  context 'Associations', :aggregate_failures do
    it { is_expected.to belong_to(:state) }
    it { is_expected.to have_many(:addresses) }
  end

  context 'Validations' do
    context '.name', :aggregate_failures do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_uniqueness_of(:name).scoped_to(:state_id) }
      it { is_expected.to validate_length_of(:name).is_at_least(2) }
      it { is_expected.to validate_length_of(:name).is_at_most(45) }
    end
    
    context '.capital', :aggregate_failures do
      it { is_expected.to validate_presence_of(:capital) }
      it { is_expected.not_to allow_value(nil).for(:capital) }
    end
  end
end
