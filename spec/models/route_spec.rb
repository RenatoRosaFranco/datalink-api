# frozen_string_literal: true

# == Schema Information
#
# Table name: routes
#
#  id         :integer          not null, primary key
#  name       :string
#  slug       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Route, type: :model do
  subject { FactoryBot.build(:route, name: 'Turismo I') }

  context 'Attributes' do
    it 'should respond to all attributes', :aggregate_failures do
      expect(subject).to respond_to(:name)
      expect(subject).to respond_to(:slug)
    end
  end

  context 'Associations', :aggregate_failures do
    it { is_expected.to have_many(:places) }
    it { is_expected.to have_many(:route_places) }
  end

  context 'Validations' do
    context '.name' do
      it { is_expected.to validate_uniqueness_of(:name) }
    end
  end
end
