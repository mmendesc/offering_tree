# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/pay_rates/', type: :request do
  describe 'POST /pay_rates' do
    subject(:create_pay_rate) { post endpoint, params: params }

    let(:endpoint) { '/api/v1/pay_rates' }
    let(:name) { 'Rate name' }
    let(:params) do
      {
        pay_rate: {
          rate_name_char: name,
          base_rate_per_client: '5.00'
        }
      }
    end
    let(:pay_rate) { create(:pay_rate) }
    let(:create_double) { instance_double(PayRates::Create.to_s, call: pay_rate) }

    before do
      allow(PayRates::Create).to receive(:new).and_return(create_double)
    end

    it 'call the create service' do
      create_pay_rate

      expect(create_double).to have_received(:call).with(ActionController::Parameters.new(params[:pay_rate]).permit!)
    end

    context 'when request is missing params' do
      let(:params) do
        {
          pay_rate2: {
            rate_name_char: name,
            base_rate_per_client: '5.00'
          }
        }
      end

      it 'return 400 status code' do
        create_pay_rate

        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'GET /api/v1/pay_rates/:id/pay_amount' do
    subject(:get_amount) { get endpoint, params: params }

    let(:endpoint) { "/api/v1/pay_rates/#{pay_rate.id}/pay_amount" }
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

  describe 'PUT /api/v1/pay_rates/:id' do
    subject(:update_pay_rate) { put endpoint, params: params }

    let(:endpoint) { "/api/v1/pay_rates/#{pay_rate.id}" }
    let(:pay_rate) { create(:pay_rate) }
    let(:params) do
      {
        pay_rate: {
          rate_name_char: 'New Name',
          base_rate_per_client: '4.00'
        }
      }
    end

    let(:update_double) { instance_double(PayRates::Update.to_s, call: pay_rate) }

    before do
      allow(PayRates::Update).to receive(:new).and_return(update_double)
    end

    it 'updates the pay rate' do
      update_pay_rate

      expect(update_double).to have_received(:call).with(pay_rate, ActionController::Parameters.new(params[:pay_rate]).permit!)
    end
  end
end
