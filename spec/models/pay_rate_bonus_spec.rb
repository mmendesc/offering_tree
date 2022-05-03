# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PayRateBonus, type: :model do
  subject { build(:pay_rate_bonus) }

  describe 'associations' do
    it { is_expected.to belong_to(:pay_rate) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:rate_per_client) }
  end

  describe 'custom validations' do
    describe '#client_limit_set' do
      subject { build(:pay_rate_bonus, min_client_count: nil, max_client_count: nil) }

      it 'should not be valid' do
        expect(subject.valid?).to be_falsey
      end
    end
  end
end
