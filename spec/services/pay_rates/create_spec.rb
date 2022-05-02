# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PayRates::Create do
  describe '#call' do
    subject(:create_pay_rate) { described_class.new.call(params) }

    let(:name) { 'Rate name' }
    let(:params) do
      {
        rate_name_char: name,
        base_rate_per_client: 5.00
      }
    end

    it 'creates a pay rate' do
      expect { create_pay_rate }.to change(PayRate, :count).by(1)
    end

    context 'when has a pay rate bonus' do
      let(:params) do
        {
          rate_name_char: 'Rate name',
          base_rate_per_client: 5.00,
          pay_rate_bonus_attributes: {
            rate_per_client: 3.00,
            min_client_count: 25
          }
        }
      end

      it 'creates a pay rate' do
        expect { create_pay_rate }.to change(PayRate, :count).by(1)
                                                             .and change(PayRateBonus, :count).by(1)
      end
    end

    context 'with a name longer than 50 characters' do
      let(:name) { Array.new(51) { rand(65..90).chr }.join }

      it 'does not creates a pay rate' do
        expect { create_pay_rate }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when bonus does not have client limits' do
      let(:params) do
        {
          rate_name_char: 'Rate name',
          base_rate_per_client: 5.00,
          pay_rate_bonus_attributes: {
            rate_per_client: 3.00
          }
        }
      end

      it 'does not creates a pay rate and bonus' do
        expect { create_pay_rate }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when bonus does not have client rate' do
      let(:params) do
        {
          rate_name_char: 'Rate name',
          base_rate_per_client: 5.00,
          pay_rate_bonus_attributes: {
            min_client_count: 25
          }
        }
      end

      it 'does not creates a pay rate' do
        expect { create_pay_rate }.to raise_error(ActiveRecord::NotNullViolation)
      end
    end
  end
end
