# frozen_string_literal: true

module Api
  module V1
    class PayRatesController < ApplicationController
      rescue_from(
        ActiveRecord::RecordInvalid,
        ActiveRecord::NotNullViolation
      ) do |exception|
        render_errors(:unprocessable_entity, exception)
      end

      rescue_from(ActionController::ParameterMissing) do |exception|
        render_errors(:bad_request, exception)
      end

      def create
        pay_rate = PayRates::Create.new.call(pay_rate_params)

        render json: ::Api::V1::PayRateSerializer.new(pay_rate)
      end

      def update
        updated_pay_rate = PayRates::Update.new.call(pay_rate, pay_rate_params)

        render json: ::Api::V1::PayRateSerializer.new(updated_pay_rate)
      end

      def pay_amount
        amount = PayRates::CalculatePayAmount.new.call(pay_rate, clients.to_i)

        amount_struct = OpenStruct.new(amount: amount, id: pay_rate_id, clients: clients.to_i)

        render json: ::Api::V1::AmountSerializer.new(amount_struct)
      end

      private

      def pay_rate
        PayRate.find(pay_rate_id)
      end

      def pay_rate_id
        params.require(:id)
      end

      def clients
        params.require(:clients)
      end

      def pay_rate_params
        params.require(:pay_rate).permit(
          :rate_name_char,
          :base_rate_per_client,
          pay_rate_bonus_attributes: %i[
            id
            rate_per_client
            min_client_count
            max_client_count
          ]
        )
      end
    end
  end
end
