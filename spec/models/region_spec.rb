# frozen_string_literal: true

# == Schema Information
#
# Table name: regions
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Region, type: :model do
  subject { FactoryBot.build(:region, name: 'Sul') }

  context 'Attributes' do
    it 'should respond to all attributes' do
      expect(subject).to respond_to(:name)
    end
  end

  context 'Associations' do
    it { is_expected.to have_many(:states) }
  end

  context 'Validations' do
    context '.name', :aggregate_failures do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_uniqueness_of(:name) }
      it { is_expected.to validate_length_of(:name).is_at_least(2) }
      it { is_expected.to validate_length_of(:name).is_at_most(18) }
    end
  end
end
