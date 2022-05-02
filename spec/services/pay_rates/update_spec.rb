# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PayRates::Update do
  describe '#call' do
    subject(:update_pay_rate) { described_class.new.call(pay_rate, params) }

    let!(:pay_rate) { create(:pay_rate) }
    let(:name) { 'New name' }
    let(:params) do
      {
        rate_name_char: name,
        base_rate_per_client: 3.00
      }
    end

    it 'updates the pay rate' do
      update_pay_rate
      pay_rate.reload
      expect(pay_rate.attributes.values_at('rate_name_char', 'base_rate_per_client')).to eq ['New name', 3.00]
    end

    context 'when has a pay rate bonus' do
      let!(:pay_rate_bonus) { create(:pay_rate_bonus, pay_rate: pay_rate, rate_per_client: 5.0)}
      let(:params) do
        {
          rate_name_char: 'New name',
          base_rate_per_client: 5.00,
          pay_rate_bonus_attributes: {
            rate_per_client: 3.00,
            min_client_count: 25,
            max_client_count: 40
          }
        }
      end

      it 'update the pay rate and the bonus' do
        update_pay_rate
        pay_rate.reload

        attributes = [pay_rate.rate_name_char, pay_rate.pay_rate_bonus.rate_per_client]

        expect(attributes).to eq ['New name', 3.0]
      end
    end

    context 'with a name longer than 50 characters' do
      let(:name) { Array.new(51) { rand(65..90).chr }.join }

      it 'does not update the pay rate' do
        expect { update_pay_rate }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end

    context 'when bonus does not have client limits' do
      let(:params) do
        {
          rate_name_char: 'Rate name',
          base_rate_per_client: 5.00,
          pay_rate_bonus_attributes: {
            rate_per_client: 3.00,
            min_client_count: nil,
            max_client_count: nil
          }
        }
      end

      it 'does not updates the pay rate and bonus' do
        expect { update_pay_rate }.to raise_error(ActiveRecord::RecordInvalid)
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

      it 'does not update the pay rate' do
        expect { update_pay_rate }.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
