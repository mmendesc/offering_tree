# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PayRates::CalculatePayAmount do
  describe '#call' do
    subject(:calculate_amount) { described_class.new.call(pay_rate, num_clients) }

    let(:pay_rate) { create(:pay_rate, base_rate_per_client: 5.00) }
    let(:num_clients) { 15 }

    it 'returns the total amount to be paid' do
      expect(calculate_amount).to eq 75.0
    end

    context 'when has a payment rate bonus' do
      let(:num_clients) { 30 }
      let(:min_client_count) { 25 }

      before do
        create(:pay_rate_bonus, min_client_count: min_client_count, max_client_count: 40, pay_rate: pay_rate)
      end

      it 'returns the total amount to be paid' do
        expect(calculate_amount).to eq 165.0
      end

      context 'when has payment rate bonus but clients are less than the required' do
        let(:num_clients) { 15 }

        it 'returns the total amount to be paid' do
          expect(calculate_amount).to eq 75.0
        end
      end

      context 'when has payment rate bonus but clients exceeds the maximum' do
        let(:num_clients) { 45 }

        it 'returns the total amount to be paid' do
          expect(calculate_amount).to eq 270.0
        end
      end

      context 'when has only a max client limitation' do
        let(:min_client_count) { nil }

        it 'returns the total amount to be paid' do
          expect(calculate_amount).to eq 240.0
        end
      end
    end
  end
end
