# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/pay_rates/', type: :request do
  describe 'POST /pay_rates' do
    subject(:create_pay_rate) { post endpoint, params: params }

    let(:endpoint) { '/pay_rates' }
    let(:name) { 'Rate name' }
    let(:params) do
      {
        pay_rate: {
          rate_name_char: name,
          base_rate_per_client: '5.00'
        }
      }
    end
    let(:create_double) { instance_double(PayRates::Create.to_s, call: true) }

    before do
      allow(PayRates::Create).to receive(:new).and_return(create_double)
    end

    it 'call the create service' do
      create_pay_rate

      expect(create_double).to have_received(:call).with(ActionController::Parameters.new(params[:pay_rate]).permit!)
    end
  end

  describe 'GET /pay_rates/:id/pay_amount' do
    subject(:get_amount) { get endpoint, params: params }

    let(:endpoint) { "/pay_rates/#{pay_rate.id}/pay_amount" }
    let(:pay_rate) { create(:pay_rate) }
    let(:params) do
      {
        clients: 30
      }
    end
    let(:calculate_double) { instance_double(PayRates::CalculatePayAmount.to_s) }

    before do
      allow(PayRates::CalculatePayAmount).to receive(:new).and_return(calculate_double)
      allow(calculate_double).to receive(:call)
    end

    it 'calls the calculate service' do
      get_amount

      expect(calculate_double).to have_received(:call).with(pay_rate, 30)
    end
  end

  describe 'PUT /pay_rates/:id' do
    subject(:update_pay_rate) { put endpoint, params: params }

    let(:endpoint) { "/pay_rates/#{pay_rate.id}" }
    let(:pay_rate) { create(:pay_rate) }
    let(:params) do
      {
        pay_rate: {
          rate_name_char: 'New Name',
          base_rate_per_client: '4.00'
        }
      }
    end

    let(:calculate_double) { instance_double(PayRates::CalculatePayAmount.to_s) }

    before do
      allow(PayRate).to receive(:find).and_return(pay_rate)
      allow(pay_rate).to receive(:update)
    end

    it 'updates the pay rate' do
      update_pay_rate

      expect(pay_rate).to have_received(:update).with(ActionController::Parameters.new(params[:pay_rate]).permit!)
    end
  end
end
