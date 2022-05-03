# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PayRate, type: :model do
  subject { build(:pay_rate) }

  describe 'associations' do
    it { is_expected.to have_one(:pay_rate_bonus) }
    it { is_expected.to accept_nested_attributes_for(:pay_rate_bonus) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:rate_name_char) }
    it { is_expected.to validate_length_of(:rate_name_char).is_at_most(50) }
  end
end
