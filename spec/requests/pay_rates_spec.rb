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

    it 'call the create service' do
      create_pay_rate

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).deep_symbolize_keys).to include(
        data: {
          id: be_a(String),
          type: 'pay_rate',
          attributes: {
            rate_name_char: name,
            base_rate_per_client: 5.0,
            min_client_count: nil,
            max_client_count: nil,
            rate_per_client: nil
          }
        }
      )
    end

    context 'with a valid pay rate bonus' do
      let(:params) do
        {
          pay_rate: {
            rate_name_char: name,
            base_rate_per_client: '5.00',
            pay_rate_bonus_attributes: {
              rate_per_client: 3.0,
              min_client_count: 20
            }
          }
        }
      end

      it 'create the pay rate and bonus' do
        create_pay_rate

        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body).deep_symbolize_keys).to include(
          data: {
            id: be_a(String),
            type: 'pay_rate',
            attributes: {
              rate_name_char: name,
              base_rate_per_client: 5.0,
              min_client_count: 20,
              max_client_count: nil,
              rate_per_client: 3.0
            }
          }
        )
      end
    end

    context 'when pay rate bonus is invalid' do
      let(:params) do
        {
          pay_rate: {
            rate_name_char: name,
            base_rate_per_client: '5.00',
            pay_rate_bonus_attributes: {
              rate_per_client: 3.0
            }
          }
        }
      end

      it 'return 422 status code' do
        create_pay_rate

        expect(response).to have_http_status(:unprocessable_entity)
      end
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

    it 'calls the calculate service' do
      get_amount

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).deep_symbolize_keys).to include(
        data: {
          id: pay_rate.id.to_s,
          type: 'amount',
          attributes: {
            clients: params[:clients],
            amount: 150.0
          }
        }
      )
    end

    context 'when request is missing params' do
      let(:params) do
        {
          clients2: 30
        }
      end

      it 'return 400 status code' do
        get_amount

        expect(response).to have_http_status(:bad_request)
      end
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

    it 'updates the pay rate' do
      update_pay_rate

      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body).deep_symbolize_keys).to include(
        data: {
          id: pay_rate.id.to_s,
          type: 'pay_rate',
          attributes: {
            rate_name_char: 'New Name',
            base_rate_per_client: 4.0,
            min_client_count: nil,
            max_client_count: nil,
            rate_per_client: nil
          }
        }
      )
    end

    context 'when request is missing params' do
      let(:params) do
        {
          clients2: 30
        }
      end

      it 'return 400 status code' do
        update_pay_rate

        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
